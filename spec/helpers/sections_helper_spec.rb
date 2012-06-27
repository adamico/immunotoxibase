require 'spec_helper'

describe SectionsHelper do
  describe "#breadcrumb" do
    let(:chapter) {Section.create!(name: "chapter")}
    let(:family) {Section.create!(name: "family", parent_id: chapter.id)}
    let(:molecule) {Section.create!(name: "molecule", parent_id: family.id)}
    context "when provided item is nil" do
      it "displays nothing" do
        helper.breadcrumb(nil, nil).should == nil
      end
    end
    context "when current item is a root element" do
      it "displays link to TOC" do
        html = "<div class=\"subnav\"><ul class=\"breadcrumb\"><li><a href=\"/toc\">Table of Contents</a></li><li class=\"active\"><span class=\"divider\">&gt;</span><i class=\"icon-white icon-book\"></i> chapter</li></ul></div>"
        helper.breadcrumb(chapter, "chapter").should == html
      end
    end
    context "when item has 1 ancestor" do
      it "displays TOC > Ancestor > item" do
        html = "<div class=\"subnav\"><ul class=\"breadcrumb\"><li><a href=\"/toc\">Table of Contents</a></li><li><span class=\"divider\">&gt;</span><a href=\"/toc/chapter\"><i class=\"icon-white icon-book\"></i> chapter</a></li><li class=\"active\"><span class=\"divider\">&gt;</span><i class=\"icon-white icon-file\"></i> family</li></ul></div>"
        helper.breadcrumb(family, "family").should == html
      end
    end
    context "when item has 2 ancestors" do
      it "displays a breadcrumb with item name preceded by ancestor name + ' > ' for each ancestor" do
        html = "<div class=\"subnav\"><ul class=\"breadcrumb\"><li><a href=\"/toc\">Table of Contents</a></li><li><span class=\"divider\">&gt;</span><a href=\"/toc/chapter\"><i class=\"icon-white icon-book\"></i> chapter</a></li><li><span class=\"divider\">&gt;</span><a href=\"/toc/chapter/family\"><i class=\"icon-white icon-file\"></i> family</a></li><li class=\"active\"><span class=\"divider\">&gt;</span><i class=\"icon-white icon-tint\"></i> molecule</li></ul></div>"
        helper.breadcrumb(molecule, "molecule").should == html
      end
    end
  end
end
