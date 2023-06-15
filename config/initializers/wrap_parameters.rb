# frozen_string_literal: true

# Wrap Parameters
#
# Wrap Paremeters is Rails feature that guess which model the controller responsible for.
# But in this case, make development difficult. Because we make a service that communicate only with JSON,
# not a Monsterous Monolith Application.
#
# Using Wrap parameters:
# Parameters: {
# "name"=>"hiya", "short_description"=>"contoh deskripsi pendek", "categories"=>["contoh_kategori"],
# "tags"=>["contoh_tag"], "product_image"=>"contoh.png", "price"=>200000, "merchant_code"=>"abc123",
# "merchant_name"=>"Contoh Merchant", "description"=>"contoh deskripsi panjang", "product_previews"=>["contoh.png"],
# "sku"=>"sku123",
# "product"=>{
#     "name"=>"hiya", "short_description"=>"contoh deskripsi pendek", "categories"=>["contoh_kategori"],
#     "tags"=>["contoh_tag"], "product_image"=>"contoh.png", "price"=>200000, "merchant_code"=>"abc123",
#     "merchant_name"=>"Contoh Merchant"}}
#
# Without Wrap parameters:
# Parameters: {
# "name"=>"hiya", "short_description"=>"contoh deskripsi pendek", "categories"=>["contoh_kategori"],
# "tags"=>["contoh_tag"], "product_image"=>"contoh.png", "price"=>200000, "merchant_code"=>"abc123",
# "merchant_name"=>"Contoh Merchant", "description"=>"contoh deskripsi panjang", "product_previews"=>["contoh.png"],
# "sku"=>"sku123"}
ActiveSupport.on_load(:action_controller) do
  wrap_parameters false # default is set to format [:json] or initializer not defined
end
