import 'package:flutter/material.dart';
import 'package:latihan_resto/gapped.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      child: ListView(
        children: [
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 750),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: gapped([
                  Text(
                    "Warung Ajib",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.asset("assets/culinary.jpg"),
                  ),
                  Center(
                    child: SizedBox(
                      width: 275,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          tombolEmail(),
                          tombolTelphone(),
                          tombolPeta(),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Deskripsi",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    "**Warung Ajib** adalah tempat yang pas buat kamu yang ingin menikmati "
                    "hidangan segar dan menyegarkan! Dengan tagline *Semuanya Ajib*, kami menghadirkan "
                    "aneka menu spesial yang siap memuaskan selera. Menu andalan kami adalah *Es Teh Ajib*, "
                    "minuman teh dengan rasa yang segar dan manis, cocok dinikmati kapan saja. Setiap tegukan "
                    "#EstehAjib memberi kesegaran maksimal, apalagi dipadukan dengan aneka camilan khas Warung Ajib "
                    "yang tak kalah nikmat. Temukan berbagai menu lainnya yang pastinya *ajib* banget, hanya di "
                    "#WarungAjib!.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "List Menu",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                  // Daftar Menu
                  const MenuItem(
                    name: "Es Teh Ajib",
                    description:
                        "Es Teh Ajib, penyegar alami sejati yang akan memulihkan tenaga dan semangat Anda! "
                        "Tanpa pengawet atau pemanis buatan berbahaya. Es Teh Ajib aman dan sehat untuk dinikmati "
                        "sehari-hari. Segarkan hari Anda dengan Es Teh Ajib! Segera kunjungi gerai atau outlet terdekat "
                        "di kota Anda. Es Teh Ajib, minuman penyegar alami untuk kehidupan lebih segar! "
                        "#EsTehAjib #SegarkanHarimu #MinumanSehatAlami #warungajib #semuanyaajib",
                    price: 3,
                  ),
                  const MenuItem(
                    name: "Classic Caesar Salad",
                    description: "Ini juga enak tenan.....",
                    price: 20,
                  ),
                  const MenuItem(
                    name: "Savory Mushroom Risotto",
                    description:
                        "Creamy Arborio rice cooked with a medley of wild mushrooms, white wine, and Parmesan cheese.",
                    price: 25,
                  ),
                  const MenuItem(
                    name: "Grilled Atlantic Salmon",
                    description:
                        "Fresh Atlantic salmon fillet seasoned and grilled to perfection, served with a lemon-dill sauce and steamed asparagus.",
                    price: 60,
                  ),
                  const MenuItem(
                    name: "Mouthwatering BBQ Chicken Bacon Sandwich",
                    description:
                        "These mouth-watering Slow Cooker BBQ Pulled Chicken Sandwiches are the ultimate comfort food "
                        "and are perfect for any occasion! Tender, juicy chicken is simmered with barbecue sauce and served up "
                        "on a soft bun with a refreshing, crunchy slaw. This dish is a definite crowd-pleaser!",
                    price: 55,
                  ),
                  const MenuItem(
                    name: "Vegetarian Thai Red Curry",
                    description:
                        "A delightful blend of mixed vegetables and tofu simmered in a rich and fragrant Thai red curry sauce, "
                        "served with jasmine rice.",
                    price: 30,
                  ),

                  // Alamat
                  Text(
                    "Alamat",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    "Jl. Imam Bonjol No.207, Pendrikan Kidul, Kec. Semarang Tengah, Kota Semarang, Jawa Tengah 50131",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),

                  // Jam Buka
                  Text(
                    "Jam Buka",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: gapped([
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (var day in [
                            "Minggu",
                            "Senin",
                            "Selasa",
                            "Rabu",
                            "Kamis",
                            "Jumat",
                            "Sabtu"
                          ])
                            Text(day,
                                style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var _ in List.generate(7, (index) => index))
                            Text(
                              "08:00 - 20:00",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                        ],
                      ),
                    ]),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.name,
    required this.description,
    required this.price,
  });

  final String name;
  final String description;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: gapped([
        Flexible(
          child: Row(
            children: gapped([
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  "assets/dishes/$name.jpg",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: Theme.of(context).textTheme.bodyLarge),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
        Text(
          "${price}k",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ]),
    );
  }
}

// Tombol aksi
ElevatedButton tombolEmail() =>
    const ElevatedButton(onPressed: kirimEmail, child: Icon(Icons.email));

ElevatedButton tombolTelphone() =>
    const ElevatedButton(onPressed: telepon, child: Icon(Icons.phone));

ElevatedButton tombolPeta() =>
    const ElevatedButton(onPressed: bukaPeta, child: Icon(Icons.map));

// Fungsi peluncur URL
void kirimEmail() async {
  final uri = Uri(
    scheme: "mailto",
    path: "estehajib@gmail.com",
    query: "subject=Tanya Seputar Resto",
  );

  if (!await launchUrl(uri)) {
    throw Exception("Gagal membuka link email!");
  }
}

void telepon() async {
  final uri = Uri(scheme: "tel", path: "085602004718");

  if (!await launchUrl(uri)) {
    throw Exception("Gagal membuka link telepon!");
  }
}

void bukaPeta() async {
  final uri = Uri(
    scheme: "geo",
    path: "-7.022162,110.506912",
    query: "q=Es Teh Ajib",
  );

  if (!await launchUrl(uri)) {
    throw Exception("Gagal membuka link peta!");
  }
}
