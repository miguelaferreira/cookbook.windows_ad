# Monkey patching the CookbookCompiler class to make sure that any _role cookbooks
# are loaded first. This way we can make our _role cookbooks behave the same as
# native Chef roles. The only additional thing you need to do is make sure you set
# all attributes as default! (note the addtional !) in your _role cookbook.

class Chef
  class RunContext
    class CookbookCompiler
      # Loads attributes files from cookbooks. Attributes files are loaded
      # according to #custom_cookbook_order; within a cookbook, +default.rb+
      # is loaded first, then the remaining attributes files in lexical sort
      # order.
      def compile_attributes
        @events.attribute_load_start(count_files_by_segment(:attributes))
        custom_cookbook_order.each do |cookbook|
          load_attributes_from_cookbook(cookbook)
        end
        @events.attribute_load_complete
      end

      # Extracts the cookbook names from the expanded run list, then iterates
      # over the list, recursing through dependencies to give a run_list
      # ordered array of cookbook names with no duplicates. Dependencies appear
      # before the cookbook(s) that depend on them, except for _role cookbooks
      # which are placed at the beginning at the array to simpulate Chef roles.
      def custom_cookbook_order
        @custom_cookbook_order ||= begin
          ordered_cookbooks = []
          seen_cookbooks = {}
          run_list_expansion.recipes.each do |recipe|
            cookbook = Chef::Recipe.parse_recipe_name(recipe).first
            custom_add_cookbook_with_deps(ordered_cookbooks, seen_cookbooks, cookbook)
          end
          Chef::Log.debug("Cookbooks to compile: #{ordered_cookbooks.inspect}")
          ordered_cookbooks
        end
      end

      # Builds up the list of +ordered_cookbooks+ by first recursing through the
      # dependencies of +cookbook+, and then adding +cookbook+ to the list of
      # +ordered_cookbooks+. If the cookbook name is ending with '_role', it's
      # inserted to the beginning of the set, otherwise it's appended at the end.
      # A cookbook is skipped if it appears in +seen_cookbooks+, otherwise it is
      # added to the set of +seen_cookbooks+ before its dependencies are processed.
      def custom_add_cookbook_with_deps(ordered_cookbooks, seen_cookbooks, cookbook)
        return false if seen_cookbooks.key?(cookbook)

        seen_cookbooks[cookbook] = true
        each_cookbook_dep(cookbook) do |dependency|
          custom_add_cookbook_with_deps(ordered_cookbooks, seen_cookbooks, dependency)
        end

        if cookbook.to_s.end_with?('_role')
          ordered_cookbooks.insert(0, cookbook)
        else
          ordered_cookbooks << cookbook
        end
      end
    end
  end
end
