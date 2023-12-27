import 'package:atomic_notes/utility/component/my_appbar.dart';
import 'package:flutter/material.dart';

class TCPage extends StatelessWidget {
  const TCPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff29283A),
      appBar: const MyAppBar(text: "TERMS AND CONDITIONS"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Last updated December 24, 2023",
                  style: TextStyle(color: Colors.grey.shade100, fontSize: 14),
                ),
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
                  "AGREEMENT TO OUR LEGAL TERMS",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'Welcome to use Atomic Notes software and services! The software and services are provided by Atomic Notes Company Limited (hereinafter referred to as "we", "us", "our"). In order to use Atomic Notes software and services (hereinafter referred to as "the Software"), you should read and abide by the "Atomic Notes Terms of Use" (hereinafter referred to as "the Agreement") and the "Atomic Notes Privacy Policy". Please read carefully and fully understand the content of each clause, especially the clauses for exemption or limitation of liability, and the separate agreement for the use of a certain service, and choose to accept or not. Unless you have read and accepted all the terms of this agreement, you have no right to download, install or use this product and related services. Your download, installation, use, login and other actions shall be deemed to have read and agreed to the above agreement',
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "We operate the mobile application Atomic Notes (the 'App'), as well as any other related products and services that refer or link to these legal terms (the 'Legal Terms') (collectively, the 'Services').",
                style: TextStyle(color: Colors.grey.shade100, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'Atomic Notes is a note taking application that secure your data with impeccable encryption and delivers real-time cloud sync. Our application is designed to provide you with a robust and encrypted experience for optimizing your thoughts. Atomic Notes ensures the only you have access to your personal data and important information and the application comes with offline and online cloud storage synchronization. The application comes with offline local storage, so you can access your notes at any time without an internet connection. For the safety of notes, cloud backup is available in the application with a fast cloud sync function. Atomic Notes provides the user with complete control over their cloud synchronization with the cloud sync button. Content in notes contains a title, a note, and a creation date and time. Keep in mind that tiles appear in grid view.',
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "These Legal Terms constitute a legally binding agreement made between you, whether personally or on behalf of an entity ('you'), and Atomic Notes inc, concerning your access to and use of the Services. You agree that by accessing the Services, you have read, understood, and agreed to be bound by all of these Legal Terms. IF YOU DO NOT AGREE WITH ALL OF THESE LEGAL TERMS, THEN YOU ARE EXPRESSLY PROHIBITED FROM USING THE SERVICES AND YOU MUST DISCONTINUE USE IMMEDIATELY.",
                style: TextStyle(color: Colors.grey.shade100, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'The Services are intended for users who are at least 13 years of age. All users who are minors in the jurisdiction in which they reside (generally under the age of 18) must have the permission of, and be directly supervised by, their parent or guardian to use the Services. If you are a minor, you must have your parent or guardian read and agree to these Legal Terms prior to you using the Services.',
                style: TextStyle(color: Colors.grey.shade100, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                '1. The scope of the Agreement',
                style: TextStyle(color: Colors.grey.shade100, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 10),
              child: Text(
                '**1.1 The scope of the Agreement This agreement is an agreement between you and us regarding your download, installation, use, copying of this software, and use of Atomic Notes related services.\n\n**1.2 This license agreement points to content The license content under this agreement refers to the Atomic Notes software license and services (hereinafter referred to as "the service") that we provide to users.The content of this agreement also includes relevant agreements and business rules that we may continue to publish on this service. Once the above content is officially released, it is an integral part of this agreement, and you should also abide by it.',
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'This Privacy Policy governs the collection, use, and protection of your information by our Note App with Cloud Sync. Please read this policy carefully to understand how we handle your data.',
                style: TextStyle(color: Colors.grey.shade100, fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 10),
              child: Text(
                '**1. Information Collected: - We collect and store notes, including text, images, and other data, to facilitate the note-taking service - User account information, such as usernames, email addresses, and authentication tokens, is collected for account creation and secure cloud synchronization.\n\n**2. Cloud Sync: - To enable cloud synchronization, your notes are securely stored on our servers. This ensures seamless access to your notes across multiple devices.\n\n**3. Data Security: - Industry-standard encryption protocols are employed to protect your data during transmission and storage. This safeguards against unauthorized access, disclosure, or alteration.\n\n**4. User Consent: - By using our Note App with Cloud Sync, you explicitly consent to the collection, storage, and processing of your data as outlined in this Privacy Policy.\n\n**5. Third-Party Cloud Services: - We may use third-party cloud services for data storage and synchronization. Please review the privacy policies of these services for additional details on how your data is handled.\n\n**6. Usage Analytics: - Anonymized usage data may be collected to enhance app functionality and user experience. This data is used for internal analysis and improvement purposes.\n\n**7. Advertising: - The app may display advertisements. Ad providers may collect information; refer to their privacy policies for details.\n\n**8. Cookies and Similar Technologies: - Cookies and similar technologies may be used to enhance user experience and track app usage. Users can manage cookie preferences in their device settings.\n\n**9. Access Controls: - Users have control over their notes and may choose to enable or disable cloud synchronization at any time. This allows users to manage where their data is stored.\n\n**10. Updates: - This Privacy Policy may be updated to reflect changes in our practices. Users will be notified of any significant updates.\n\n**11. Contact Information: - For questions or concerns regarding this Privacy Policy, please contact [devbehindyou@gmail.com].',
                style: TextStyle(color: Colors.grey.shade300, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'Effective Date: [24-12-2023]',
                style: TextStyle(color: Colors.grey.shade100, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                'Thank you for trusting our Atomic Notes App with Cloud Sync. We prioritize the security and privacy of your data to provide you with a seamless note-taking experience.',
                style: TextStyle(color: Colors.grey.shade100, fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
