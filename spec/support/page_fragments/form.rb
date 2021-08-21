module PageFragments
  module Form
    def for(form_action)
      Form.new(page.find("form[action=\"#{form_action}\"]"))
    end

    class Form
      attr_accessor :node

      def initialize(node)
        @node = node
      end

      def submit(args = {})
        fill_in(args)
        node.find("[type=submit]").click
      end

      def fill_in(args = {})
        args.each do |label_text, value|
          if value == true
            node.check(label_text)
          elsif value == false
            node.uncheck(label_text)
          elsif value.instance_of?(String)
            node.fill_in(label_text, with: value)
          end
        end
      end

      def select(*args)
        node.select(*args)
      end
    end
  end
end
