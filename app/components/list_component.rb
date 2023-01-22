class ListComponent < ViewComponent::Base
  renders_many :items, -> (label, value) do
    capture do
      concat content_tag(:div, label, class: 'list-label')
      concat content_tag(:div, value)
    end
  end
end
