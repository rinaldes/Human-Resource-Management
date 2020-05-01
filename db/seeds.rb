# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# #
# # Examples:
# #
# #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# #   Mayor.create(name: 'Emanuel', city: cities.first)
# # require 'bcrypt'

# ActiveRecord::Base.establish_connection
# ActiveRecord::Base.connection.tables.each do |table|
#   if !["schema_migrations"].include?(table)
#     puts "TRUNCATE #{table}"
#     ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
#     ActiveRecord::Base.connection.reset_pk_sequence!(table)
#   end
# end

# Category.where(name: 'Business').first_or_create
# Category.where(name: 'Lifestyle').first_or_create
# Category.where(name: 'Education').first_or_create
# Category.where(name: 'Technology').first_or_create
# Category.where(name: 'Entertainment').first_or_create
# Category.where(name: 'Funpage').first_or_create

#  User.create!(
#   :email => 'hrmpinus@gmail.com',
#   :password => 'password',
#   :encrypted_password => BCrypt::Password.create('password'),
#   :confirmed_at => DateTime.now,
#   :username => 'admin',
#   :first_name => 'super',
#   :last_name => 'admin',
#   :birth_place => 'hometown',
#   :birth_date => Date.today,
#   :gender => 'male',
#   :status => 'active',
#   :role => 'admin'
# )
 
# Province.create([{ name: 'Aceh', capital: 'Banda Aceh' }, { name: 'Sumatera Utara', capital: 'Medan' }, { name: 'Sumatera Barat', capital: 'Padang' }, { name: 'Riau', capital: 'Pekanbaru' }, { name: 'Jambi', capital: 'Jambi' }, { name: 'Sumatera Selatan', capital: 'Palembang' }, { name: 'Bengkulu', capital: 'Bengkulu' }, { name: 'Lampung', capital: 'Bandar Lampung' }, { name: 'Kepulauan Bangka Belitung', capital: 'Pangkal Pinang' }, { name: 'Kepulauan Riau', capital: 'Tanjung Pinang' }, { name: 'Jakarta', capital: 'Jakarta' }, { name: 'Yogyakarta', capital: 'Yogyakarta' }, { name: 'Jawa Barat', capital: 'Bandung' }, { name: 'Jawa Tengah', capital: 'Semarang' }, { name: 'Jawa Timur', capital: 'Surabaya' }, { name: 'Banten', capital: 'Serang' }, { name: 'Bali', capital: 'Denpasar' }, { name: 'Nusa Tenggara Timur', capital: 'Kupang' }, { name: 'Nusa Tenggara Barat', capital: 'Mataram' }, { name: 'Kalimantan Barat', capital: 'Pontianak' }, { name: 'Kalimantan Tengah', capital: 'Palangka Raya' }, { name: 'Kalimantan Selatan', capital: 'Banjarmasin' }, { name: 'Kalimantan Timur', capital: 'Samarinda' }, { name: 'Kalimantan Utara', capital: 'Tanjung Selor' }, { name: 'Sulawesi Utara', capital: 'Menado' }, { name: 'Sulawesi Tengah', capital: 'Palu' }, { name: 'Sulawesi Selatan', capital: 'Makassar' }, { name: 'Sulawesi Tenggara', capital: 'Kendari' }, { name: 'Sulawesi Barat', capital: 'Mamuju' }, { name: 'Gorontalo', capital: 'Gorontalo' }, { name: 'Maluku', capital: 'Ambon' }, { name: 'Maluku Utara', capital: 'Sofifi' }, { name: 'Papua', capital: 'Jayapura' }, { name: 'Papua Barat', capital: 'Manokwari' }])

# ## Kota
# ### Aceh
# City.create([{ name: 'Kabupaten Aceh Barat', province_id: 1 },{ name: 'Kabupaten Aceh Barat Daya', province_id: 1 },{ name: 'Kabupaten Aceh Besar', province_id: 1 },{ name: 'Kabupaten Aceh Jaya', province_id: 1 },{ name: 'Kabupaten Aceh Selatan', province_id: 1 },{ name: 'Kabupaten Aceh Singkil', province_id: 1 },{ name: 'Kabupaten Aceh Tamiang', province_id: 1 },{ name: 'Kabupaten Aceh Tengah', province_id: 1 },{ name: 'Kabupaten Aceh Tenggara', province_id: 1 },{ name: 'Kabupaten Aceh Timur', province_id: 1 },{ name: 'Kabupaten Aceh Utara', province_id: 1 },{ name: 'Kabupaten Bener Meriah', province_id: 1 },{ name: 'Kabupaten Bireuen', province_id: 1 },{ name: 'Kabupaten Gayo Lues', province_id: 1 },{ name: 'Kabupaten Nagan Raya', province_id: 1 },{ name: 'Kabupaten Pidie', province_id: 1 },{ name: 'Kabupaten Pidie Jaya', province_id: 1 },{ name: 'Kabupaten Simeulue', province_id: 1 },{ name: 'Kota Banda Aceh', province_id: 1 },{ name: 'Kota Langsa', province_id: 1 },{ name: 'Kota Lhokseumawe', province_id: 1 },{ name: 'Kota Sabang', province_id: 1 },{ name: 'Kota Subulussalam', province_id: 1 }])

# ### sumatera uatara
# City.create([{ name: 'Kabupaten Asahan', province_id: 2 },{ name: 'Kabupaten Batubara', province_id: 2 },{ name: 'Kabupaten Dairi', province_id: 2 },{ name: 'Kabupaten Deli Serdang', province_id: 2 },{ name: 'Kabupaten Humbang Hasundutan', province_id: 2 },{ name: 'Kabupaten Karo', province_id: 2 },{ name: 'Kabupaten Labuhanbatu', province_id: 2 },{ name: 'Kabupaten Labuhanbatu Selatan', province_id: 2 },{ name: 'Kabupaten Labuhanbatu Utara', province_id: 2 },{ name: 'Kabupaten Langkat', province_id: 2 },{ name: 'Kabupaten Mandailing Natal', province_id: 2 },{ name: 'Kabupaten Nias', province_id: 2 },{ name: 'Kabupaten Nias Barat', province_id: 2 },{ name: 'Kabupaten Nias Selatan', province_id: 2 },{ name: 'Kabupaten Nias Utara', province_id: 2 },{ name: 'Kabupaten Padang Lawas', province_id: 2 },{ name: 'Kabupaten Padang Lawas Utara', province_id: 2 },{ name: 'Kabupaten Pakpak Bharat', province_id: 2 },{ name: 'Kabupaten Samosir', province_id: 2 },{ name: 'Kabupaten Serdang Bedagai', province_id: 2 },{ name: 'Kabupaten Simalungun', province_id: 2 },{ name: 'Kabupaten Tapanuli Selatan', province_id: 2 },{ name: 'Kabupaten Tapanuli Tengah', province_id: 2 },{ name: 'Kabupaten Tapanuli Utara', province_id: 2 },{ name: 'Kabupaten Toba Samosir', province_id: 2 },{ name: 'Kota Binjai', province_id: 2 },{ name: 'Kota Gunungsitoli', province_id: 2 },{ name: 'Kota Medan', province_id: 2 },{ name: 'Kota Padangsidempuan', province_id: 2 },{ name: 'Kota Pematangsiantar', province_id: 2 },{ name: 'Kota Sibolga', province_id: 2 },{ name: 'Kota Tanjungbalai', province_id: 2 },{ name: 'Kota Tebing Tinggi', province_id: 2 }])

# ### Sumatra Barat
# City.create([{ name: 'Kabupaten Agam', province_id: 3 },{ name: 'Kabupaten Dharmasraya', province_id: 3 },{ name: 'Kabupaten Kepulauan Mentawai', province_id: 3 },{ name: 'Kabupaten Lima Puluh Kota', province_id: 3 },{ name: 'Kabupaten Padang Pariaman', province_id: 3 },{ name: 'Kabupaten Pasaman', province_id: 3 },{ name: 'Kabupaten Pasaman Barat', province_id: 3 },{ name: 'Kabupaten Pesisir Selatan', province_id: 3 },{ name: 'Kabupaten Sijunjung', province_id: 3 },{ name: 'Kabupaten Solok', province_id: 3 },{ name: 'Kabupaten Solok Selatan', province_id: 3 },{ name: 'Kabupaten Tanah Datar', province_id: 3 },{ name: 'Kota Bukittinggi', province_id: 3 },{ name: 'Kota Padang', province_id: 3 },{ name: 'Kota Padangpanjang', province_id: 3 },{ name: 'Kota Pariaman', province_id: 3 },{ name: 'Kota Payakumbuh', province_id: 3 },{ name: 'Kota Sawahlunto', province_id: 3 },{ name: 'Kota Solok', province_id: 3 }])

# ### Riau
# City.create([{ name: 'Kabupaten Bengkalis', province_id: 4 },{ name: 'Kabupaten Indragiri Hilir', province_id: 4 },{ name: 'Kabupaten Indragiri Hulu', province_id: 4 },{ name: 'Kabupaten Kampar', province_id: 4 },{ name: 'Kabupaten Kuantan Singingi', province_id: 4 },{ name: 'Kabupaten Pelalawan', province_id: 4 },{ name: 'Kabupaten Rokan Hilir', province_id: 4 },{ name: 'Kabupaten Rokan Hulu', province_id: 4 },{ name: 'Kabupaten Siak', province_id: 4 },{ name: 'Kabupaten Kepulauan Meranti', province_id: 4 },{ name: 'Kota Dumai', province_id: 4 },{ name: 'Kota Pekanbaru', province_id: 4 }])

# ### Jambi
# City.create([{ name: 'Kabupaten Batanghari', province_id: 5 },{ name: 'Kabupaten Bungo', province_id: 5 },{ name: 'Kabupaten Kerinci', province_id: 5 },{ name: 'Kabupaten Merangin', province_id: 5 },{ name: 'Kabupaten Muaro Jambi', province_id: 5 },{ name: 'Kabupaten Sarolangun', province_id: 5 },{ name: 'Kabupaten Tanjung Jabung Barat', province_id: 5 },{ name: 'Kabupaten Tanjung Jabung Timur', province_id: 5 },{ name: 'Kabupaten Tebo', province_id: 5 },{ name: 'Kota Jambi', province_id: 5 },{ name: 'Kota Sungai Penuh', province_id: 5 }])

# ### sumatera selatan
# City.create([{ name: 'Kabupaten Banyuasin', province_id: 6 },{ name: 'Kabupaten Empat Lawang', province_id: 6 },{ name: 'Kabupaten Lahat', province_id: 6 },{ name: 'Kabupaten Muara Enim', province_id: 6 },{ name: 'Kabupaten Musi Banyuasin', province_id: 6 },{ name: 'Kabupaten Musi Rawas', province_id: 6 },{ name: 'Kabupaten Musi Rawas Utara', province_id: 6 },{ name: 'Kabupaten Ogan Ilir', province_id: 6 },{ name: 'Kabupaten Ogan Komering Ilir', province_id: 6 },{ name: 'Kabupaten Ogan Komering Ulu', province_id: 6 },{ name: 'Kabupaten Ogan Komering Ulu Selatan', province_id: 6 },{ name: 'Kabupaten Penukal Abab Lematang Ilir', province_id: 6 },{ name: 'Kabupaten Ogan Komering Ulu Timur', province_id: 6 },{ name: 'Kota Lubuklinggau', province_id: 6 },{ name: 'Kota Pagar Alam', province_id: 6 },{ name: 'Kota Palembang', province_id: 6 },{ name: 'Kota Prabumulih', province_id: 6 }])

# ### Bengkulu
# City.create([{ name: 'Kabupaten Bengkulu Selatan', province_id: 7 },{ name: 'Kabupaten Bengkulu Tengah', province_id: 7 },{ name: 'Kabupaten Bengkulu Utara', province_id: 7 },{ name: 'Kabupaten Kaur', province_id: 7 },{ name: 'Kabupaten Kepahiang', province_id: 7 },{ name: 'Kabupaten Lebong', province_id: 7 },{ name: 'Kabupaten Mukomuko', province_id: 7 },{ name: 'Kabupaten Rejang Lebong', province_id: 7 },{ name: 'Kabupaten Seluma', province_id: 7 },{ name: 'Kota Bengkulu', province_id: 7 }])

# ### Lampung
# City.create([{ name: 'Kabupaten Lampung Tengah', province_id: 8 },{ name: 'Kabupaten Lampung Utara', province_id: 8 },{ name: 'Kabupaten Lampung Selatan', province_id: 8 },{ name: 'Kabupaten Lampung Barat', province_id: 8 },{ name: 'Kabupaten Lampung Timur', province_id: 8 },{ name: 'Kabupaten Mesuji', province_id: 8 },{ name: 'Kabupaten Pesawaran', province_id: 8 },{ name: 'Kabupaten Pesisir Barat', province_id: 8 },{ name: 'Kabupaten Pringsewu', province_id: 8 },{ name: 'Kabupaten Tulang Bawang', province_id: 8 },{ name: 'Kabupaten Tulang Bawang Barat', province_id: 8 },{ name: 'Kabupaten Tanggamus', province_id: 8 },{ name: 'Kabupaten Way Kanan', province_id: 8 },{ name: 'Kota Bandar Lampung', province_id: 8 },{ name: 'Kota Metro', province_id: 8 }])

# ### kepulauan bangka Belitung
# City.create([{ name: 'Kabupaten Bangka', province_id: 9 },{ name: 'Kabupaten Bangka Barat', province_id: 9 },{ name: 'Kabupaten Bangka Selatan', province_id: 9 },{ name: 'Kabupaten Bangka Tengah', province_id: 9 },{ name: 'Kabupaten Belitung', province_id: 9 },{ name: 'Kabupaten Belitung Timur', province_id: 9 },{ name: 'Kota Pangkal Pinang', province_id: 9 }])

# ### kepulauan riau
# City.create([{ name: 'Kabupaten Bintan', province_id: 10 },{ name: 'Kabupaten Karimun', province_id: 10 },{ name: 'Kabupaten Kepulauan Anambas', province_id: 10 },{ name: 'Kabupaten Lingga', province_id: 10 },{ name: 'Kabupaten Natuna', province_id: 10 },{ name: 'Kota Batam', province_id: 10 },{ name: 'Kota Tanjung Pinang', province_id: 10 }])

# ### Jakarta
# City.create([{ name: 'Kabupaten Kepulauan Seribu', province_id: 11 },{ name: 'Kota Jakarta Barat', province_id: 11 },{ name: 'Kota Jakarta Pusat', province_id: 11 },{ name: 'Kota Jakarta Selatan', province_id: 11 },{ name: 'Kota Jakarta Timur', province_id: 11 },{ name: 'Kota Jakarta Utara', province_id: 11 }])

# ### Yogyakarta
# City.create([{ name: 'Kabupaten Bantul', province_id: 12 },{ name: 'Kabupaten Gunung Kidul', province_id: 12 },{ name: 'Kabupaten Kulon Progo', province_id: 12 },{ name: 'Kabupaten Sleman', province_id: 12 },{ name: 'Kota Yogyakarta', province_id: 12 }])  

# ### JawaBarat
# City.create([{ name: 'Kabupaten Bandung', province_id: 13 },{ name: 'Kabupaten Bandung Barat', province_id: 13 },{ name: 'Kabupaten Bekasi', province_id: 13 },{ name: 'Kabupaten Bogor', province_id: 13 },{ name: 'Kabupaten Ciamis', province_id: 13 },{ name: 'Kabupaten Cianjur', province_id: 13 },{ name: 'Kabupaten Cirebon', province_id: 13 },{ name: 'Kabupaten Garut', province_id: 13 },{ name: 'Kabupaten Indramayu', province_id: 13 },{ name: 'Kabupaten Karawang', province_id: 13 },{ name: 'Kabupaten Kuningan', province_id: 13 },{ name: 'Kabupaten Majalengka', province_id: 13 },{ name: 'Kabupaten Pangandaran', province_id: 13 },{ name: 'Kabupaten Purwakarta', province_id: 13 },{ name: 'Kabupaten Subang', province_id: 13 },{ name: 'Kabupaten Sukabumi', province_id: 13 },{ name: 'Kabupaten Sumedang', province_id: 13 },{ name: 'Kabupaten Tasikmalaya', province_id: 13 },{ name: 'Kota Bandung', province_id: 13 },{ name: 'Kota Banjar', province_id: 13 },{ name: 'Kota Bekasi', province_id: 13 },{ name: 'Kota Bogor', province_id: 13 },{ name: 'Kota Cimahi', province_id: 13 },{ name: 'Kota Cirebon', province_id: 13 },{ name: 'Kota Depok', province_id: 13 },{ name: 'Kota Sukabumi', province_id: 13 },{ name: 'Kota Tasikmalaya', province_id: 13 }])

# ### jawa Tengah
# City.create([{ name: 'Kabupaten Banjarnegara', province_id: 14 },{ name: 'Kabupaten Banyumas', province_id: 14 },{ name: 'Kabupaten Batang', province_id: 14 },{ name: 'Kabupaten Blora', province_id: 14 },{ name: 'Kabupaten Boyolali', province_id: 14 },{ name: 'Kabupaten Brebes', province_id: 14 },{ name: 'Kabupaten Cilacap', province_id: 14 },{ name: 'Kabupaten Demak', province_id: 14 },{ name: 'Kabupaten Grobogan', province_id: 14 },{ name: 'Kabupaten Jepara', province_id: 14 },{ name: 'Kabupaten Karanganyar', province_id: 14 },{ name: 'Kabupaten Kebumen', province_id: 14 },{ name: 'Kabupaten Kendal', province_id: 14 },{ name: 'Kabupaten Klaten', province_id: 14 },{ name: 'Kabupaten Kudus', province_id: 14 },{ name: 'Kabupaten Magelang', province_id: 14 },{ name: 'Kabupaten Pati', province_id: 14 },{ name: 'Kabupaten Pekalongan', province_id: 14 },{ name: 'Kabupaten Pemalang', province_id: 14 },{ name: 'Kabupaten Purbalingga', province_id: 14 },{ name: 'Kabupaten Purworejo', province_id: 14 },{ name: 'Kabupaten Rembang', province_id: 14 },{ name: 'Kabupaten Semarang', province_id: 14 },{ name: 'Kabupaten Sragen', province_id: 14 },{ name: 'Kabupaten Sukoharjo', province_id: 14 },{ name: 'Kabupaten Tegal', province_id: 14 },{ name: 'Kabupaten Temanggung', province_id: 14 },{ name: 'Kabupaten Wonogiri', province_id: 14 },{ name: 'Kabupaten Wonosobo', province_id: 14 },{ name: 'Kota Magelang', province_id: 14 },{ name: 'Kota Pekalongan', province_id: 14 },{ name: 'Kota Salatiga', province_id: 14 },{ name: 'Kota Semarang', province_id: 14 },{ name: 'Kota Surakarta', province_id: 14 },{ name: 'Kota Tegal', province_id: 14 }])


# ### Jawa timur
# City.create([{ name: 'Kabupaten Bangkalan', province_id: 15 },{ name: 'Kabupaten Banyuwangi', province_id: 15 },{ name: 'Kabupaten Blitar', province_id: 15 },{ name: 'Kabupaten Bojonegoro', province_id: 15 },{ name: 'Kabupaten Bondowoso', province_id: 15 },{ name: 'Kabupaten Gresik', province_id: 15 },{ name: 'Kabupaten Jember', province_id: 15 },{ name: 'Kabupaten Jombang', province_id: 15 },{ name: 'Kabupaten Kediri', province_id: 15 },{ name: 'Kabupaten Lamongan', province_id: 15 },{ name: 'Kabupaten Lumajang', province_id: 15 },{ name: 'Kabupaten Madiun', province_id: 15 },{ name: 'Kabupaten Magetan', province_id: 15 },{ name: 'Kabupaten Malang', province_id: 15 },{ name: 'Kabupaten Mojokerto', province_id: 15 },{ name: 'Kabupaten Nganjuk', province_id: 15 },{ name: 'Kabupaten Ngawi', province_id: 15 },{ name: 'Kabupaten Pacitan  ', province_id: 15 },{ name: 'Kabupaten Pamekasan', province_id: 15 },{ name: 'Kabupaten Pasuruan', province_id: 15 },{ name: 'Kabupaten Ponorogo', province_id: 15 },{ name: 'Kabupaten Probolinggo', province_id: 15 },{ name: 'Kabupaten Sampang', province_id: 15 },{ name: 'Kabupaten Sidoarjo', province_id: 15 },{ name: 'Kabupaten Situbondo', province_id: 15 },{ name: 'Kabupaten Sumenep', province_id: 15 },{ name: 'Kabupaten Trenggalek', province_id: 15 },{ name: 'Kabupaten Tuban', province_id: 15 },{ name: 'Kabupaten Tulungagung', province_id: 15 },{ name: 'Kota Batu', province_id: 15 },{ name: 'Kota Blitar', province_id: 15 },{ name: 'Kota Kediri', province_id: 15 },{ name: 'Kota Madiun', province_id: 15 },{ name: 'Kota Malang', province_id: 15 },{ name: 'Kota Mojokerto', province_id: 15 },{ name: 'Kota Pasuruan', province_id: 15 },{ name: 'Kota Probolinggo', province_id: 15 },{ name: 'Kota Surabaya', province_id: 15 }])

# ### Banten
# City.create([{ name: 'Kabupaten Lebak', province_id: 16 },{ name: 'Kabupaten Pandeglang', province_id: 16 },{ name: 'Kabupaten Serang', province_id: 16 },{ name: 'Kabupaten Tangerang', province_id: 16 },{ name: 'Kota Cilegon', province_id: 16 },{ name: 'Kota Serang', province_id: 16 },{ name: 'Kota Tangerang', province_id: 16 },{ name: 'Kota Tangerang Selatan', province_id: 16 }])

# ### Bali
# City.create([{ name: 'Kabupaten Badung', province_id: 17 },{ name: 'Kabupaten Bangli', province_id: 17 },{ name: 'Kabupaten Buleleng', province_id: 17 },{ name: 'Kabupaten Gianyar', province_id: 17 },{ name: 'Kabupaten Jembrana', province_id: 17 },{ name: 'Kabupaten Karangasem', province_id: 17 },{ name: 'Kabupaten Klungkung', province_id: 17 },{ name: 'Kabupaten Tabanan', province_id: 17 },{ name: 'Kota Denpasar', province_id: 17 },])

# ### nusa tenggara timur
# City.create([{ name: 'Kabupaten Alor', province_id: 18 },{ name: 'Kabupaten Belu', province_id: 18 },{ name: 'Kabupaten Ende', province_id: 18 },{ name: 'Kabupaten Flores Timur', province_id: 18 },{ name: 'Kabupaten Kupang', province_id: 18 },{ name: 'Kabupaten Lembata', province_id: 18 },{ name: 'Kabupaten Malaka', province_id: 18 },{ name: 'Kabupaten Manggarai', province_id: 18 },{ name: 'Kabupaten Manggarai Barat', province_id: 18 },{ name: 'Kabupaten Manggarai Timur', province_id: 18 },{ name: 'Kabupaten Ngada', province_id: 18 },{ name: 'Kabupaten Nagekeo', province_id: 18 },{ name: 'Kabupaten Rote Ndao', province_id: 18 },{ name: 'Kabupaten Sabu Raijua', province_id: 18 },{ name: 'Kabupaten Sikka', province_id: 18 },{ name: 'Kabupaten Sumba Barat', province_id: 18 },{ name: 'Kabupaten Sumba Barat Daya', province_id: 18 },{ name: 'Kabupaten Sumba Tengah', province_id: 18 },{ name: 'Kabupaten Sumba Timur', province_id: 18 },{ name: 'Kabupaten Timor Tengah Selatan', province_id: 18 },{ name: 'Kabupaten Timor Tengah Utara', province_id: 18 },{ name: 'Kota Kupang', province_id: 18 }])


# ### nusa tenggara Barat
# City.create([{ name: 'Kabupaten Bima', province_id: 19 },{ name: 'Kabupaten Dompu', province_id: 19 },{ name: 'Kabupaten Lombok Barat', province_id: 19 },{ name: 'Kabupaten Lombok Tengah', province_id: 19 },{ name: 'Kabupaten Lombok Timur', province_id: 19 },{ name: 'Kabupaten Lombok Utara', province_id: 19 },{ name: 'Kabupaten Sumbawa', province_id: 19 },{ name: 'Kabupaten Sumbawa Barat', province_id: 19 },{ name: 'Kota Bima', province_id: 19 },{ name: 'Kota Mataram', province_id: 19 }])

# ### kalimantan Barat
# City.create([{ name: 'Kabupaten Bengkayang', province_id: 20 },{ name: 'Kabupaten Kapuas Hulu', province_id: 20 },{ name: 'Kabupaten Kayong Utara', province_id: 20 },{ name: 'Kabupaten Ketapang', province_id: 20 },{ name: 'Kabupaten Kubu Raya', province_id: 20 },{ name: 'Kabupaten Landak', province_id: 20 },{ name: 'Kabupaten Melawi', province_id: 20 },{ name: 'Kabupaten Mempawah', province_id: 20 },{ name: 'Kabupaten Sambas', province_id: 20 },{ name: 'Kabupaten Sanggau', province_id: 20 },{ name: 'Kabupaten Sekadau', province_id: 20 },{ name: 'Kabupaten Sintang', province_id: 20 },{ name: 'Kota Pontianak', province_id: 20 },{ name: 'Kota Singkawang', province_id: 20 }])

# ### kalimantan Tengah
# City.create([{ name: 'Kabupaten Barito Selatan', province_id: 21 },{ name: 'Kabupaten Barito Timur', province_id: 21 },{ name: 'Kabupaten Barito Utara', province_id: 21 },{ name: 'Kabupaten Gunung Mas', province_id: 21 },{ name: 'Kabupaten Kapuas', province_id: 21 },{ name: 'Kabupaten Katingan', province_id: 21 },{ name: 'Kabupaten Kotawaringin Barat', province_id: 21 },{ name: 'Kabupaten Kotawaringin Timur', province_id: 21 },{ name: 'Kabupaten Lamandau', province_id: 21 },{ name: 'Kabupaten Murung Raya', province_id: 21 },{ name: 'Kabupaten Pulang Pisau', province_id: 21 },{ name: 'Kabupaten Sukamara', province_id: 21 },{ name: 'Kabupaten Seruyan', province_id: 21 },{ name: 'Kota Palangka Raya', province_id: 21 }])

# ### kalimatan selatan
# City.create([{ name: 'Kabupaten Balangan', province_id: 22 },{ name: 'Kabupaten Banjar', province_id: 22 },{ name: 'Kabupaten Barito Kuala', province_id: 22 },{ name: 'Kabupaten Hulu Sungai Selatan', province_id: 22 },{ name: 'Kabupaten Hulu Sungai Tengah', province_id: 22 },{ name: 'Kabupaten Hulu Sungai Utara', province_id: 22 },{ name: 'Kabupaten Kotabaru', province_id: 22 },{ name: 'Kabupaten Tabalong', province_id: 22 },{ name: 'Kabupaten Tanah Bumbu', province_id: 22 },{ name: 'Kabupaten Tanah Laut', province_id: 22 },{ name: 'Kabupaten Tapin', province_id: 22 },{ name: 'Kota Banjarbaru', province_id: 22 },{ name: 'Kota Banjarmasin', province_id: 22 }])

# ### kalimantan timur
# City.create([{ name: 'Kabupaten Berau', province_id: 23 },{ name: 'Kabupaten Kutai Barat', province_id: 23 },{ name: 'Kabupaten Kutai Kartanegara', province_id: 23 },{ name: 'Kabupaten Kutai Timur', province_id: 23 },{ name: 'Kabupaten Paser', province_id: 23 },{ name: 'Kabupaten Penajam Paser Utara', province_id: 23 },{ name: 'Kabupaten Mahakam Ulu', province_id: 23 },{ name: 'Kota Balikpapan', province_id: 23 },{ name: 'Kota Bontang', province_id: 23 },{ name: 'Kota Samarinda', province_id: 23 }])

# ### kalimantan Utara
# City.create([{ name: 'Kota Tarakan', province_id: 24 },{ name: 'Kabupaten Nunukan', province_id: 24 },{ name: 'Kabupaten Bulungan', province_id: 24 },{ name: 'Kabupaten Malinau', province_id: 24 },{ name: 'Kabupaten Tana Tidung', province_id: 24 }])

# ### sulawesi Utara
# City.create([{ name: 'Kabupaten Bolaang Mongondow', province_id: 25 },{ name: 'Kabupaten Bolaang Mongondow Selatan', province_id: 25 },{ name: 'Kabupaten Bolaang Mongondow Timur', province_id: 25 },{ name: 'Kabupaten Bolaang Mongondow Utara', province_id: 25 },{ name: 'Kabupaten Kepulauan Sangihe', province_id: 25 },{ name: 'Kabupaten Kepulauan Siau Tagulandang Biaro', province_id: 25 },{ name: 'Kabupaten Kepulauan Talaud', province_id: 25 },{ name: 'Kabupaten Minahasa', province_id: 25 },{ name: 'Kabupaten Minahasa Selatan', province_id: 25 },{ name: 'Kabupaten Minahasa Tenggara', province_id: 25 },{ name: 'Kabupaten Minahasa Utara', province_id: 25 },{ name: 'Kota Bitung', province_id: 25 },{ name: 'Kota Kotamobagu', province_id: 25 },{ name: 'Kota Manado', province_id: 25 },{ name: 'Kota Tomohon', province_id: 25 }])

# ### sulawesi Tengah
# City.create([{ name: 'Kabupaten Banggai', province_id: 26 },{ name: 'Kabupaten Banggai Kepulauan', province_id: 26 },{ name: 'Kabupaten Banggai Laut', province_id: 26 },{ name: 'Kabupaten Buol', province_id: 26 },{ name: 'Kabupaten Donggala', province_id: 26 },{ name: 'Kabupaten Morowali', province_id: 26 },{ name: 'Kabupaten Morowali Utara', province_id: 26 },{ name: 'Kabupaten Parigi Moutong', province_id: 26 },{ name: 'Kabupaten Poso', province_id: 26 },{ name: 'Kabupaten Sigi', province_id: 26 },{ name: 'Kabupaten Tojo Una-Una', province_id: 26 },{ name: 'Kabupaten Tolitoli', province_id: 26 },{ name: 'Kota Palu', province_id: 26 }])

# ### sulawesi selatan
# City.create([{ name: 'Kabupaten Bantaeng', province_id: 27 },{ name: 'Kabupaten Barru', province_id: 27 },{ name: 'Kabupaten Bone', province_id: 27 },{ name: 'Kabupaten Bulukumba', province_id: 27 },{ name: 'Kabupaten Enrekang', province_id: 27 },{ name: 'Kabupaten Gowa', province_id: 27 },{ name: 'Kabupaten Jeneponto', province_id: 27 },{ name: 'Kabupaten Kepulauan Selayar', province_id: 27 },{ name: 'Kabupaten Luwu', province_id: 27 },{ name: 'Kabupaten Luwu Timur', province_id: 27 },{ name: 'Kabupaten Luwu Utara', province_id: 27 },{ name: 'Kabupaten Maros', province_id: 27 },{ name: 'Kabupaten Pangkajene dan Kepulauan', province_id: 27 },{ name: 'Kabupaten Pinrang', province_id: 27 },{ name: 'Kabupaten Sidenreng Rappang', province_id: 27 },{ name: 'Kabupaten Sinjai', province_id: 27 },{ name: 'Kabupaten Soppeng', province_id: 27 },{ name: 'Kabupaten Takalar', province_id: 27 },{ name: 'Kabupaten Tana Toraja', province_id: 27 },{ name: 'Kabupaten Toraja Utara', province_id: 27 },{ name: 'Kabupaten Wajo', province_id: 27 },{ name: 'Kota Makassar', province_id: 27 },{ name: 'Kota Palopo', province_id: 27 },{ name: 'Kota Parepare', province_id: 27 }])

# ### sulawesi tenggara
# City.create([{ name: 'Kabupaten Bombana', province_id: 28 },{ name: 'Kabupaten Buton', province_id: 28 },{ name: 'Kabupaten Buton Selatan', province_id: 28 },{ name: 'Kabupaten Buton Tengah', province_id: 28 },{ name: 'Kabupaten Buton Utara', province_id: 28 },{ name: 'Kabupaten Kolaka', province_id: 28 },{ name: 'Kabupaten Kolaka Timur', province_id: 28 },{ name: 'Kabupaten Kolaka Utara', province_id: 28 },{ name: 'Kabupaten Konawe', province_id: 28 },{ name: 'Kabupaten Konawe Selatan', province_id: 28 },{ name: 'Kabupaten Konawe Utara', province_id: 28 },{ name: 'Kabupaten Konawe Kepulauan', province_id: 28 },{ name: 'Kabupaten Muna', province_id: 28 },{ name: 'Kabupaten Muna Barat', province_id: 28 },{ name: 'Kabupaten Wakatobi', province_id: 28 },{ name: 'Kota Bau-Bau', province_id: 28 },{ name: 'Kota Kendari', province_id: 28 }])

# ### sulawesi Barat
# City.create([{ name: 'Kabupaten Majene', province_id: 29 },{ name: 'Kabupaten Mamasa', province_id: 29 },{ name: 'Kabupaten Mamuju', province_id: 29 },{ name: 'Kabupaten Mamuju Utara', province_id: 29 },{ name: 'Kabupaten Polewali Mandar', province_id: 29 },{ name: 'Kabupaten Mamuju Tengah', province_id: 29 }])

# ### Gorontalo
# City.create([{ name: 'Kabupaten Boalemo', province_id: 30 },{ name: 'Kabupaten Bone Bolango', province_id: 30 },{ name: 'Kabupaten Gorontalo', province_id: 30 },{ name: 'Kabupaten Gorontalo Utara', province_id: 30 },{ name: 'Kabupaten Pohuwato', province_id: 30 },{ name: 'Kota Gorontalo', province_id: 30 }])

# ### Maluku
# City.create([{ name: 'Kabupaten Buru', province_id: 31 },{ name: 'Kabupaten Buru Selatan', province_id: 31 },{ name: 'Kabupaten Kepulauan Aru', province_id: 31 },{ name: 'Kabupaten Maluku Barat Daya', province_id: 31 },{ name: 'Kabupaten Maluku Tengah', province_id: 31 },{ name: 'Kabupaten Maluku Tenggara', province_id: 31 },{ name: 'Kabupaten Maluku Tenggara Barat', province_id: 31 },{ name: 'Kabupaten Seram Bagian Barat', province_id: 31 },{ name: 'Kabupaten Seram Bagian Timur', province_id: 31 },{ name: 'Kota Ambon', province_id: 31 },{ name: 'Kota Tual', province_id: 31 }])

# ### maluku Utara
# City.create([{ name: 'Kabupaten Halmahera Barat', province_id: 32 },{ name: 'Kabupaten Halmahera Tengah', province_id: 32 },{ name: 'Kabupaten Halmahera Utara', province_id: 32 },{ name: 'Kabupaten Halmahera Selatan', province_id: 32 },{ name: 'Kabupaten Halmahera Timur', province_id: 32 },{ name: 'Kabupaten Kepulauan Sula', province_id: 32 },{ name: 'Kabupaten Pulau Morotai', province_id: 32 },{ name: 'Kabupaten Pulau Taliabu', province_id: 32 },{ name: 'Kota Ternate', province_id: 32 },{ name: 'Kota Tidore Kepulauan', province_id: 32 }])

# ### Papua
# City.create([{ name: 'Kabupaten Asmat', province_id: 33 },{ name: 'Kabupaten Biak Numfor', province_id: 33 },{ name: 'Kabupaten Boven Digoel', province_id: 33 },{ name: 'Kabupaten Deiyai', province_id: 33 },{ name: 'Kabupaten Dogiyai', province_id: 33 },{ name: 'Kabupaten Intan Jaya', province_id: 33 },{ name: 'Kabupaten Jayapura', province_id: 33 },{ name: 'Kabupaten Jayawijaya', province_id: 33 },{ name: 'Kabupaten Keerom', province_id: 33 },{ name: 'Kabupaten Kepulauan Yapen', province_id: 33 },{ name: 'Kabupaten Lanny Jaya', province_id: 33 },{ name: 'Kabupaten Mamberamo Raya', province_id: 33 },{ name: 'Kabupaten Mamberamo Tengah', province_id: 33 },{ name: 'Kabupaten Mappi', province_id: 33 },{ name: 'Kabupaten Merauke', province_id: 33 },{ name: 'Kabupaten Mimika', province_id: 33 },{ name: 'Kabupaten Nabire', province_id: 33 },{ name: 'Kabupaten Nduga', province_id: 33 },{ name: 'Kabupaten Paniai', province_id: 33 },{ name: 'Kabupaten Pegunungan Bintang', province_id: 33 },{ name: 'Kabupaten Puncak', province_id: 33 },{ name: 'Kabupaten Puncak Jaya', province_id: 33 },{ name: 'Kabupaten Sarmi', province_id: 33 },{ name: 'Kabupaten Supiori', province_id: 33 },{ name: 'Kabupaten Tolikara', province_id: 33 },{ name: 'Kabupaten Waropen', province_id: 33 },{ name: 'Kabupaten Yahukimo', province_id: 33 },{ name: 'Kabupaten Yalimo', province_id: 33 },{ name: 'Kota Jayapura', province_id: 33 }])

# ### papua Barat
# City.create([{ name: 'Kabupaten Fakfak', province_id: 34 },{ name: 'Kabupaten Kaimana', province_id: 34 },{ name: 'Kabupaten Manokwari', province_id: 34 },{ name: 'Kabupaten Manokwari Selatan', province_id: 34 },{ name: 'Kabupaten Maybrat', province_id: 34 },{ name: 'Kabupaten Pegunungan Arfak', province_id: 34 },{ name: 'Kabupaten Raja Ampat', province_id: 34 },{ name: 'Kabupaten Sorong', province_id: 34 },{ name: 'Kabupaten Sorong Selatan', province_id: 34 },{ name: 'Kabupaten Tambrauw', province_id: 34 },{ name: 'Kabupaten Teluk Bintuni', province_id: 34 },{ name: 'Kabupaten Teluk Wondama', province_id: 34 },{ name: 'Kota Sorong', province_id: 34 }])



FeatureName.create([
  {name: 'user_managements'},
  {name: 'roles'},
  {name: 'approval_levels'},
  {name: 'approval_employees'},
  {name: 'visions'},
  {name: 'misions'},
  {name: 'cultures'},
  {name: 'code_of_conducts'},
  {name: 'values'},
  {name: 'attendance_settings'},
  {name: 'goal_values'},
  {name: 'goals'},
  {name: 'components'},
  {name: 'holidays'},
  {name: 'shifts'},
  {name: 'organizations'},
  {name: 'schedules'},
  {name: 'recruitments'},
  {name: 'test_results'},
  {name: 'interview_results'},
  {name: 'employees'},
  {name: 'employee_surveys'},
  {name: 'personal_datas'},
  {name: 'employee_resigns'},
  {name: 'performances'},
  {name: 'families'},
  {name: 'employee_histories'},
  {name: 'education_details'},
  {name: 'internal_work_experiences'},
  {name: 'external_work_experiences'},
  {name: 'history_of_organizations'},
  {name: 'certifications'},
  {name: 'employee_working_datas'},
  {name: 'position_details'},
  {name: 'contracts'},
  {name: 'training_histories'},
  {name: 'skills'},
  {name: 'violation_details'},
  {name: 'salaries'},
  {name: 'absences'},
  {name: 'overtime_requests'},
  {name: 'leave_requests'},
  {name: 'appraisals'},
  {name: 'assets_assignments'},
  {name: 'knowledges'},
  {name: 'blast_messages'},
  {name: 'photos'},
  {name: 'photo_activities'},
  {name: 'categories'},
  {name: 'devisions'}
])

FeatureName.all.each{|f|
  Feature.create feature_name_id: f.id, role_id: Role.find_by_name('admin').id
}