import 'package:atomic_notes/utility/component/logo_container.dart';
import 'package:atomic_notes/utility/component/my_appbar.dart';
import 'package:flutter/material.dart';

class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff29283A),
      appBar: const MyAppBar(
        text: "About",
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const LogoContainer(),
            const SizedBox(height: 40),

            // version info
            const Text(
              "Version: 1.11.1 (3)",
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            const Text("© 2023 Atomic Notes",
                style: TextStyle(color: Colors.white, fontSize: 13)),
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: const Color(0xff323130),
                    borderRadius: BorderRadius.circular(7)),
                child: const Text(
                  "Secure Note App with Offline and Cloud Sync",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                "Welcome to Atomic Notes, where we blend the simplicity of note-taking with the highest standards of security. Our mission is to provide users with a versatile and secure platform that combines the convenience of offline access with the power of encrypted cloud synchronization.",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                "Our Vision:\nAt Atomic Notes, we envision a world where capturing thoughts, ideas, and inspirations is not only effortless but also protected by top-tier encryption. Our Note App is designed to be your digital vault, ensuring the privacy and security of your most valuable information.",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 10),
              child: Text(
                "Key Features:\n**Offline Accessibility: Enjoy the freedom to create, edit, and access your notes even without an internet connection. Your productivity is no longer tethered to connectivity.\n\n**Encrypted Cloud Sync: We prioritize the security of your data. Our app employs robust encryption measures during cloud synchronization, ensuring that your notes remain confidential and protected.\n\n**Intuitive Interface: Simplicity meets security. Our user-friendly interface ensures that you can navigate the app seamlessly, with the added assurance that your data is encrypted for privacy.\n\n**Privacy First: Your thoughts are personal, and we respect that. Our app is designed with a privacy-first approach, ensuring that your notes are shielded from unauthorized access.\n\n**Why Choose Atomic: Security Assurance: We take encryption seriously. Your data is encrypted both on your device and during cloud synchronization, providing you with peace of mind regarding the confidentiality of your notes.\n\n**Adaptability: Whether you prefer the flexibility of offline note-taking or the convenience of synchronized access across devices, our app adapts to your preferences without compromising on security.\n\n**Continuous Innovation: Security is a journey, not a destination. Expect regular updates and enhancements as we strive to maintain the highest standards of encryption and improve your overall experience.",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                "Join Us on this Secure Journey:\nAt Atomic Notes, we invite you to join us on this secure journey of capturing thoughts, making ideas tangible, and staying organized with the utmost privacy. Your feedback is crucial in shaping the future of our Note App, so please reach out and share your thoughts.",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                "Thank you for choosing Atomic Notes as your secure note-taking companion. Let's create, capture, and organize securely together!",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                "**The operating system may still gather usage data.",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: const Color(0xff323130),
                    borderRadius: BorderRadius.circular(7)),
                child: const Text(
                  "App License Agreement",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                "This App License Agreement 'Agreement' is entered into between the end user 'User' and 'Atomic Notes', the creator of the app Atomic Notes. By installing and using the App, the User agrees to the terms and conditions outlined in this Agreement",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 10),
              child: Text(
                "**1. Grant of License: - Atomic grants the User a non-exclusive, non-transferable license to use the App on compatible devices solely for personal or business purposes.\n\n*2. Restrictions: - The User may not reverse engineer, modify, distribute, sell, or sublicense the App.\n - Any attempt to circumvent the security measures of the App is strictly prohibited.\n\n**3. Ownership: - Atomic retains all rights, title, and interest in and to the App, including all intellectual property rights.\n\n**4. Updates: - Atomic may provide updates to the App to enhance functionality or address issues. The User agrees to install these updates promptly.\n\n**5. User Responsibilities: - The User is responsible for maintaining the security of login credentials associated with the App.\n - Any data entered or generated by the User within the App remains the User's property.\n\n**6. Privacy: - Atomic adheres to its Privacy Policy, and the User agrees to the terms outlined in that policy.\n\n**7. Termination: - This license is effective until terminated by the User or Ensync. The User may terminate it at any time by uninstalling the App.\n\n**8. Warranty Disclaimer: - The App is provided 'as is' without warranties of any kind, either express or implied, including, but not limited to, the implied warranties of merchantability, fitness for a particular purpose, or non-infringement.\n\n**9. Limitation of Liability: - Atomic shall not be liable for any direct, indirect, incidental, special, or consequential damages arising out of the use or inability to use the App.\n\n**10. Governing Law: - This Agreement is governed by and construed in accordance with the laws of [User Jurisdiction].\n\n**11. Entire Agreement: - This Agreement constitutes the entire understanding between the User and Atomic Notes and supersedes all prior agreements, whether oral or written.\n\n**Contact Information: - For questions or concerns regarding this Agreement, please contact [devbehindyou@email.com].",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                "By installing and using the App, the User acknowledges having read and agreed to the terms and conditions outlined in this License Agreement.",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                "Effective Date: 24/12/2023",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(11.0),
              child: Text(
                "Thank you for using our App responsibly and respecting the terms of this License Agreement.",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
