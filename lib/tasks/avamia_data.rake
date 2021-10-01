namespace :avamia_data do
  desc "store json companies and naics contents"
  task add_naics: :environment do
    naics_json = File.open("public/static/naics.json", "rb") { |file| file.read }
    naics = JSON.parse(naics_json)
    naics.each do |naic|
      Naic.create!(code: naic["Code"], title: naic["Title"], description: naic["Description"])
    end
  end

  task add_companies: :environment do
    companies_json = File.open("public/static/companies.json", "rb") { |file| file.read }
    companies = JSON.parse(companies_json)
    companies.each do |company|
      naic = Naic.find_by_code(company["naics_code"])
      if naic
        resource = Company.new
        resource.name = company["name"]
        resource.avatar_url = company["avatar_url"]
        resource.business_structure = company["business_structure"]
        resource.duns_number = company["duns_number"]
        resource.naic = naic
        resource.save!
        company["addresses"].each do |address|
          address_resource = Address.new
          address_resource.address_type = address["type"]
          address_resource.street_address = address["street_address"]
          address_resource.city = address["city"]
          address_resource.state = address["state"]
          address_resource.postal_code = address["postal_code"]
          address_resource.company = resource
          address_resource.save!
        end
      end
    end
  end

end