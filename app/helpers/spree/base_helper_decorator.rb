module Spree
  module BaseHelper
   def taxons_tree(root_taxon, current_taxon, max_level = 1)
      return '' if max_level < 1 || root_taxon.children.empty?
      content_tag :ul, class: 'taxons-list' do
        root_taxon.children.map do |taxon|
          css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'current' : nil
          
          content_tag :div, class: css_class do
              taxonomy = Spree::Taxonomy.find_by_id(taxon[:taxonomy_id])
              price = taxon.name.split("-")
            if taxonomy.name == "Price" 
              check_box_tag("taxon[]", taxon.id )  +
              label(:taxon, "    #{taxon.name}")  
                check_box_tag("taxon[#{taxonomy.name}][]", taxon.id, nil, :class => "price_sub", :range_first =>  price[0].to_f, :range_second =>  price[1].to_f  )  +
              label(:taxon, "    #{taxon.name}")
            else
              check_box_tag("taxon[]", taxon.id )  +
              label(:taxon, "    #{taxon.name}")  
                check_box_tag("taxon[#{taxonomy.name}][]", taxon.id, nil, :class => "submittable", :data => taxonomy.id, :range_first =>  price[0].to_f, :range_second =>  price[1].to_f  )  +
              label(:taxon, "    #{taxon.name}")
            end  
         end
        end.join("\n").html_safe
      end
    end
  end
end     