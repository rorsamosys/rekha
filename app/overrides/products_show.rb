Deface::Override.new(:virtual_path => 'spree/products/show',
                     :name => 'products_show',
                     :replace => 'erb[loud]:contains("taxons")',
                     :partial => 'spree/shared/check_avalability')

