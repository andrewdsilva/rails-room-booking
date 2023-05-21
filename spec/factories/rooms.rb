FactoryBot.define do
  factory :room_1, class: Room do
    slug                 { "cottage-in-lot" }
    title                { "Cottage in Lot" }
    description          { "A nice place" }
    room_type            { 0 }
    num_guests           { 5 }
    num_rooms            { 3 }
    num_beds             { 4 }
    num_baths            { 1 }
    day_price            { 100 }
    self_check_in        { true }
    parking              { true }
    kitchen              { true }
    washer               { true }
    dryer                { true }
    dishwasher           { true }
    wifi                 { true }
    tv                   { true }
    bathroom_essentials  { true }
    bedroom_comforts     { true }
    coffee_maker         { true }
    hair_dryer           { true }
    location             { "Les Canavals, 46240 Cœur-de-Causse" }
    lat                  { 44.6436382 }
    long                 { 1.5619194 }
    location_description { "Parc naturel régional et Géoparc des Causses du Quercy" }
  end
end
