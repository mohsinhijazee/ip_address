# File: RAILS_ROOT/vendor/plugins/ip_address/lib/ip_address.rb

require 'detail_value.rb'

# New data type to store IP addresses
class IPAddress < DetailValue
  
  # This method is required to judge the validity of the value entered in the
  # form. This is called via AJAX when the user enters the value. Field
  # gets red if its not valid.
  # Note that its a class method
  def self.valid?(value, o)
    ip_re = /\b(([01]?\d?\d|2[0-4]\d|25[0-5])\.){3}([01]?\d?\d|2[0-4]\d|25[0-5])\b/
    puts "#THE VALUE IS #{value}"
    puts "MATCH IS => #{value.match(ip_re).to_s}"
                                 
    if value.nil? or value.match(ip_re)
      return true
    end
    return false
  end
  
  # This method is needed how would you format your value?
  # Note that its a class method
  def self.format_detail(options)
    # Return null string if no value
     return "" if options[:value].nil?
     # Default to html format if not mentioend
     options[:format]=:html if options[:format].nil?
     
     # Here you decide how you would format your value in various formats
     case options[:format]
       # How should it look in HTML
     when :html
       # We return it in plan:
       return options[:value]
       # For example, returning a link to the IP
       #return %Q{<a TARGET="_blank" href="#{options[:value]}">#{html_escape(options[:value])}</a>}
     else
      return options[:value]
     end
  end

  # How should it appear on the entry form?
  # Note that its an instance method
  def to_form_row(i=0, o={})
          entity = %Q{#{o[:form_id]}_#{o[:entity].name}}.gsub(/ /,"_")
		 id = detail.name+"["+i.to_s+"]"
	   %Q{
     <input type="hidden" id="#{o[:entity].name}_#{detail.name}[#{i.to_s}]_id" name="#{detail.name}[#{i.to_s}][id]" value="#{self.id}">
     <tr><td>#{detail.name }:</td><td><input type="text" id ="#{entity}_#{id}_value"  name="#{detail.name+"["+i.to_s+"]"}[value]" value="#{value}" /></td></tr>
		   <script type="text/javascript">
			    new DetailWatcher("#{entity}_#{id}", "#{detail['id']}");
		   </script>
		 }
  end
  
end
