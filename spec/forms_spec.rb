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
    before do
      @options = {
        :FT => :Btn,
        :T => Prawn::Core::LiteralString.new("ButtonName"),
        :DA => Prawn::Core::LiteralString.new("/Helv 0 Tf 0 g"),
        :F => 4,
        :Ff => 65536,
        :Type => :Annot,
        :Subtype => :Widget,
        :MK => {
          :CA => Prawn::Core::LiteralString.new("ButtonName"), 
          :BG => [0.75294, 0.75294, 0.75294], 
          :BC => [0.75294, 0.75294, 0.75294]
         },
         :Rect => [304.5, 537.39, 429, 552.39]
      }
    end
    
    it "adds the field to the Field's dictionary" do
      @pdf.button(@options[:T])
      
      field = @pdf.state.store.root.data[:AcroForm].data[:Fields].select { |i| i.data[:T] == @options[:T]}.first
      field.data.should == @options
    end
    
    it "references the same field in Fields & the current page's Annots" do
      field = @pdf.state.store.root.data[:AcroForm].data[:Fields].select { |i| i.data[:T] == @options[:T]}.first
      page_field = @pdf.state.page.dictionary.data[:Annots].select { |i| i.data[:T] == @options[:T]}.first      
      
      field.should == page_field
    end
    
  end
  
  describe "adding a text field" do
    before do
      @options = {
        :FT => :Tx,
        :F => 4, 
        :Rect => [36, 36, 136, -64], 
        :Ff => 0, 
        :MK => { :BC=> [0, 0, 0] }, 
        :T => "TextFieldName", 
        :BS => { :S => :S, :Type =>:Border, :W => 1}, 
        :DA => "/Helv 0 Tf 0 g",
        :Subtype => :Widget,
        :Type => :Annot
      }
    end
    
    it "adds it to the Field's dictionary" do      
      @pdf.text_field("TextFieldName", 0, 0, 100, 100)
      
      field = @pdf.state.store.root.data[:AcroForm].data[:Fields].select { |i| i.data[:T] == @options[:T]}.first
      field.data.should == @options
    end
  end
end