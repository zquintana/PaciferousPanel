module ApplicationHelper

	def icon_text(icon, text)
		raw('<span class="fi-%s"></span>%s' % [icon, text])
	end

	##
	#	def fa_icon(icon, text)
	#		raw('<span class="fa fa-%s"></span> %s' % [icon, text])
	#	end

	#	def fa_stack(icon, on_icon, text)
	#		raw('<span class="fa-stack">
	#				<span class="fa fa-%s fa-stack-2x"></span>
	#				<span class="fa fa-%s fa-stack-1x fa-inverse"></span>
	#			</span> %s' % [on_icon, icon, text])
	#	end
	
end
