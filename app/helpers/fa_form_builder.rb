class FaFormBuilder < ActionView::Helpers::FormBuilder
	def label(attribute, options={})
		if @object.errors[attribute].empty? == false
			options[:class] = "%s error" % [options[:class]]
		end

		super
	end

	def text_field(attribute, options = {})
		if @object.errors[attribute].empty? == false
			options[:class] = "%s error" % [options[:class]]
			@template.concat(super(attribute, options))
			@template.concat(@template.content_tag :small, 'this ' + @object.errors[attribute].join(' '), class: 'error')
			return
		end

		super
	end

	def password_field(attribute, options = {})
		if @object.errors[attribute].empty? == false
			options[:class] = "%s error" % [options[:class]]
			@template.concat(super(attribute, options))
			@template.concat(@template.content_tag :small, 'this ' + @object.errors[attribute].join(' '), class: 'error')
			return
		end

		super
	end
end