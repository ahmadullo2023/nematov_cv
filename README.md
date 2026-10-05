# Ahmadullo Nematov Portfolio

Responsive Flutter web portfolio based on the bottommost screen in Stitch project
`4088946633103609556`, screen `8b92ddce57a94ddda902acdfd5ffc7b9`.

Run locally with `flutter run -d chrome`. Build with `flutter build web --release`;
hosting output is in `build/web`.

Four project showcases include 16 selectable previews. Paylov uses the five supplied
`telefon_*.png` screenshots; Sharh, HR Pulse Admin, and HR Pulse Xodimlar use supplied product screenshots. The page includes
responsive navigation, skills, career history, and contact links. Fonts and their
OFL licenses are bundled locally in `assets/fonts`.

Validate with `flutter analyze` and `flutter test`. Tests cover 360, 768 and 1280 px
layouts, contact navigation and preview interaction.

Content and contact details are transcribed from Stitch. Store and enterprise links
were placeholders in the source; these controls are disabled until real URLs are
supplied. Other device previews are Flutter recreations of the Stitch mockups.
