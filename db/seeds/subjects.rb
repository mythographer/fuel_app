subjects = []
100.times do |n|
  subjects << { name_en: "Client #{n + 1}", name_ua: "Клієнт #{n + 1}" }
end
Subject.create(subjects)
