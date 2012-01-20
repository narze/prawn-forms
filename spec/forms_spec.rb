require File.dirname(__FILE__) + '/spec_helper'

describe "Prawn Forms" do
  before do
    @pdf = Prawn::Document.new(:template => "data/acro-forms-sample.pdf")
  end
  
  it "knows when a PDF has an acroform" do
    @pdf.acroform_present?.should be_true
  end
  
  it "knows when a PDF doesn't have an acroform" do
    basic_pdf = Prawn::Document.generate("data/basic_pdf.pdf")

    Prawn::Document.new(:template => "data/basic_pdf.pdf").acroform_present?.should be_false

    FileUtils.rm("data/basic_pdf.pdf")
  end
  
end