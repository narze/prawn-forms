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
  
  describe "adding a button" do
    it "sets the text properly" do
      text = "MyButtonName"
      
      @pdf.should_receive(:add_interactive_field).with(
        :Btn,
        :T => Prawn::Core::LiteralString.new(text),
        :DA => Prawn::Core::LiteralString.new("/Helv 0 Tf 0 g"),
        :F => 4,
        :Ff => 65536,
        :MK => {:CA => Prawn::Core::LiteralString.new(text), :BG => [0.75294, 0.75294, 0.75294], :BC => [0.75294, 0.75294, 0.75294]},
        :Rect => [304.5, 537.39, 429, 552.39]
      )

      @pdf.button(text)
    end

    it "adds the button to the Fields dictionary" do
      @pdf.button("ButtonName")
      field = @pdf.state.store.root.data[:AcroForm].data[:Fields].select { |i| i.data[:T] == "ButtonName"}
      field.size.should == 1
    end
    
    it "adds the button to the page's Annots" do
      @pdf.button("ButtonName")
      field = @pdf.state.page.dictionary.data[:Annots].select { |i| i.data[:T] == "ButtonName"}
      field.size.should == 1  
    end
  end
  
end