FactoryGirl.define do
  factory :section do
    sequence(:name) {|n| "section#{n}" }
  end

  factory :molecule, class: Section do
    sequence(:name) {|n| "molecule#{n}" }
  end

  factory :assessment do
    molecule
  end
end
