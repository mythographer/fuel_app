arr = %w(сірий синій коричневий зелений білий червоний чорний жовтий бежевий фіолетовий)
colors = arr.collect do |color| { name_ua: color } end
VehicleRegistrationColor.create(colors)
