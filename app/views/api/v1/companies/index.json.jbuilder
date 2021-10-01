json.success true
json.data @resources do |resource|
  json.partial! 'api/v1/companies/company', resource: resource
end
json.current_page @resources&.current_page || 1
json.per_page @resources&.per_page
json.total_entries @resources&.total_entries || 0
