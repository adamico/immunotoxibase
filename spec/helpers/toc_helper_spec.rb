require 'spec_helper'

describe TocHelper do
  describe "#breadcrumb" do
    let(:chapter) {Chapter.create!(name: "chapter")}
    let(:family) {Family.create!(name: "family", chapter_id: chapter.id)}
    let(:molecule) {Molecule.create!(name: "molecule", family_id: family.id)}
    context "when item is root" do
      it "displays nothing" do
        helper.breadcrumb(chapter).should be_nil
      end
    end
    context "when item has 1 ancestor" do
      it "displays a breadcrumb with item name preceded by ancestor name + ' > '" do
        helper.breadcrumb(family).should == "<a href=\"/assets?id=#{chapter.id}&amp;level=chapter\">chapter</a> > "
      end
    end
    context "when item has 2 ancestors" do
      it "displays a breadcrumb with item name preceded by ancestor name + ' > ' for each ancestor" do
        helper.breadcrumb(molecule).should == "<a href=\"/assets?id=#{chapter.id}&amp;level=chapter\">chapter</a> > <a href=\"/assets?id=#{family.id}&amp;level=family\">family</a> > "
      end
    end
  end
end
