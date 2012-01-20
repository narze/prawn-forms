require 'rubygems'

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

require 'prawn'
require 'prawn/forms'

@pdf = Prawn::Document.generate("basic-form-filled.pdf", :template => "data/basic-form.pdf") do |pdf|
  puts pdf.field_names # => ['fname', 'lname']
  pdf.set_field("fname", "Sonny") # Setting the 'fname' field within the PDF

  # The PDF spec allows duplicate field names so sometimes you might need to be able
  # to specify the page that a field is on. Also, according to the PDF spec the Fields
  # dictionary in the root references all of the fields within the document. There's
  # also an Annots dictionary for each page which contains references to the fields
  # relevant to that page.
  pdf.set_field("lname", "Moore", :page => 1)
end