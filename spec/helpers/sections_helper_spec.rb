require 'spec_helper'

describe SectionsHelper do
  describe "#breadcrumb" do
    let(:chapter) {Section.create!(name: "chapter")}
    let(:family) {Section.create!(name: "family", parent_id: chapter.id)}
    let(:molecule) {Section.create!(name: "molecule", parent_id: family.id)}
    context "when provided item is nil" do
      it "displays nothing" do
        helper.breadcrumb(nil).should == nil
      end
    end
    context "when current item is a root element" do
      it "displays only a link to the table of contents" do
        controller.params = {controller: "sections", action: "toc", section: chapter.id}
        html = '<ul class="breadcrumb"><li><a href="/toc">Table of Contents</a> <span class="divider">&gt;</span></li><li class="active">chapter</li></ul>'
        helper.breadcrumb(chapter).should == html
      end
    end
    context "when item has 1 ancestor" do
      it "displays a breadcrumb with item name preceded by ancestor name + ' > '" do
        controller.params = {controller: "sections", action: "toc", section: family.id}
        html = "<ul class=\"breadcrumb\"><li><a href=\"/toc\">Table of Contents</a> <span class=\"divider\">&gt;</span></li><li><a href=\"/toc?section=#{chapter.id}\">chapter</a> <span class=\"divider\">&gt;</span></li><li class=\"active\">family</li></ul>"
        helper.breadcrumb(family).should == html
      end
    end
    context "when item has 2 ancestors" do
      it "displays a breadcrumb with item name preceded by ancestor name + ' > ' for each ancestor" do
        controller.params = {controller: "sections", action: "toc", section: molecule.id}
        html = "<ul class=\"breadcrumb\"><li><a href=\"/toc\">Table of Contents</a> <span class=\"divider\">&gt;</span></li><li><a href=\"/toc?section=#{chapter.id}\">chapter</a> <span class=\"divider\">&gt;</span></li><li><a href=\"/toc?section=#{family.id}\">family</a> <span class=\"divider\">&gt;</span></li><li class=\"active\">molecule</li></ul>"
        helper.breadcrumb(molecule).should == html
      end
    end
  end
end
