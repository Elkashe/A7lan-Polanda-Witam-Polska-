import 'package:a7lanpopo/features/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:a7lanpopo/features/screens/hotels/hotels.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _firstName;
  bool _isLoadingProfile = true;
  bool _isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final user = Supabase.instance.client.auth.currentUser;

      if (user == null) {
        if (!mounted) return;

        Navigator.pushNamedAndRemoveUntil(
          context,
          Constant.login,
          (route) => false,
        );

        return;
      }

      final profile = await Supabase.instance.client
          .from('profiles')
          .select('first_name, last_name')
          .eq('id', user.id)
          .single();

      if (!mounted) return;

      setState(() {
        _firstName = profile['first_name'] as String?;
        _isLoadingProfile = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _isLoadingProfile = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not load your profile.',
          ),
        ),
      );
    }
  }

  Future<void> _logout() async {
    if (_isLoggingOut) return;

    setState(() {
      _isLoggingOut = true;
    });

    try {
      await Supabase.instance.client.auth.signOut();

      if (!mounted) return;

      Navigator.pushNamedAndRemoveUntil(
        context,
        Constant.login,
        (route) => false,
      );
    } on AuthException catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Could not log out. Please try again.',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoggingOut = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayName =
        (_firstName != null && _firstName!.trim().isNotEmpty)
            ? _firstName!.trim()
            : 'Traveler';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,

        title: Text(
          'Rahala',
          style: GoogleFonts.abhayaLibre(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),

        actions: [
          IconButton(
            tooltip: 'Profile',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile page coming soon'),
                ),
              );
            },
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.black87,
              size: 30,
            ),
          ),

          IconButton(
            tooltip: 'Logout',
            onPressed: _isLoggingOut ? null : _logout,
            icon: _isLoggingOut
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                : const Icon(
                    Icons.logout,
                    color: Colors.black87,
                  ),
          ),

          const SizedBox(width: 8),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _isLoadingProfile
                  ? const SizedBox(
                      height: 38,
                      width: 38,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                      ),
                    )
                  : Text(
                      'Welcome, $displayName 👋',
                      style: GoogleFonts.abhayaLibre(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

              const SizedBox(height: 6),

              Text(
                'Everything you need for your trip in one place.',
                style: GoogleFonts.abhayaLibre(
                  fontSize: 18,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),

                  gradient: const LinearGradient(
                    colors: [
                      Colors.purple,
                      Colors.pink,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.travel_explore,
                      color: Colors.white,
                      size: 42,
                    ),

                    const SizedBox(height: 15),

                    Text(
                      'Explore Poland',
                      style: GoogleFonts.abhayaLibre(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      'Hotels, tours, transport and more.',
                      style: GoogleFonts.abhayaLibre(
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              Text(
                'Services',
                style: GoogleFonts.abhayaLibre(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.25,

                children: [
                  _ServiceCard(
                    icon: Icons.hotel_outlined,
                    title: 'Hotels',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HotelsScreen(),
                        ),
                      );
                    },
                  ),
                  _ServiceCard(
                    icon: Icons.map_outlined,
                    title: 'Tours',
                  ),
                  _ServiceCard(
                    icon: Icons.sim_card_outlined,
                    title: 'eSIM',
                  ),
                  _ServiceCard(
                    icon: Icons.airport_shuttle_outlined,
                    title: 'Airport Transfer',
                  ),
                  _ServiceCard(
                    icon: Icons.directions_car_outlined,
                    title: 'Car Rental',
                  ),
                  _ServiceCard(
                    icon: Icons.person_outline,
                    title: 'My Profile',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const _ServiceCard({
    required this.icon,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),

      child: InkWell(
        borderRadius: BorderRadius.circular(18),

       onTap: onTap ??
    () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$title coming soon'),
        ),
      );
    },

        child: Container(
          padding: const EdgeInsets.all(18),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.black12,
            ),
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 38,
                color: Colors.purple,
              ),

              const SizedBox(height: 10),

              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.abhayaLibre(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}