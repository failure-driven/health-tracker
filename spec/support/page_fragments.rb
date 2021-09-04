module PageFragments
  Page = Struct.new(:rspec_example) do
    alias_method :page, :rspec_example
  end

  def focus_on(*args)
    require File.join(args.map(&:to_s))
    page = Page.new self
    page_fragment = args
      .map(&:to_s)
      .map(&:camelize)
      .reduce(PageFragments) do |module_name, part|
      module_name.const_get(part, false)
    end
    page = page.extend(page_fragment)
    yield page if block_given?
    page
  end
end
