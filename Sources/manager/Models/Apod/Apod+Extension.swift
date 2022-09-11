//
//  File.swift
//  
//
//  Created by José Neto on 11/09/2022.
//

import Foundation
import apiclient

extension Apod {
    public static var mockItems: [Apod] {
        var payload: String = mockPayLoad
        payload = payload.replacingOccurrences(of: "\n", with: "")
        guard let data: Data = payload.data(using: .utf8, allowLossyConversion: true) else { return [] }
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([NasaApodDto].self, from: data)
            return decodedData.compactMap({ Apod($0) })
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch {
            print("error: ", error)
        }
        return []
    }
    private static var mockPayLoad: String = """
                                             [
                                                     {
                                                         "mediaType": "image",
                                                         "id": "449DA15D-00CA-4989-8951-A68ACF795F5F",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 657417600,
                                                         "title": "A Waterfall and the Milky Way",
                                                         "copyright": "Xie Jie",
                                                         "explanation": "The dream was to capture both the waterfall and the Milky Way together. Difficulties included finding a good camera location, artificially illuminating the waterfall and the surrounding valley effectively, capturing the entire scene with numerous foreground and background shots, worrying that fireflies would be too distracting, keeping the camera dry, and avoiding stepping on a poisonous snake.  Behold the result -- captured after midnight in mid-July and digitally stitched into a wide-angle panorama. The waterfall is the picturesque Zhulian waterfall in the Luoxiao Mountains in eastern Hunan Province, China. The central band of our Milky Way Galaxy crosses the sky and shows numerous dark dust filaments and colorful nebulas. Bright stars dot the sky -- all residing in the nearby Milky Way -- including the Summer Triangle with bright Vega visible above the Milky Way's arch. After capturing all 78 component exposures for you to enjoy, the photographer and friends enjoyed the view themselves for the rest of the night.    Discovery + Outreach: Graduate student research position open for APOD",
                                                         "date": "2021-11-01",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2111/MilkyWayWaterfall_XieJie_2500.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2111/MilkyWayWaterfall_XieJie_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "thumbnailUrl": null,
                                                         "id": "51C26919-9C57-4061-91CB-F77DDF03FD7D",
                                                         "postedDate": 657331200,
                                                         "title": "Dark Matter in a Simulated Universe",
                                                         "copyright": "Tom AbelRalf KaehlerKIPACSLACAMNH",
                                                         "date": "2021-10-31",
                                                         "explanation": "Is our universe haunted?  It might look that way on this dark matter map.  The gravity of unseen dark matter is the leading explanation for why galaxies rotate so fast, why galaxies orbit clusters so fast, why gravitational lenses so strongly deflect light, and why visible matter is distributed as it is both in the local universe and on the cosmic microwave background.  The featured image from the American Museum of Natural History's Hayden Planetarium Space Show Dark Universe highlights one example of how pervasive dark matter might haunt our universe.  In this frame from a detailed computer simulation, complex filaments of dark matter, shown in black, are strewn about the universe like spider webs, while the relatively rare clumps of familiar baryonic matter are colored orange. These simulations are good statistical matches to astronomical observations.  In what is perhaps a scarier turn of events, dark matter -- although quite strange and in an unknown form -- is no longer thought to be the strangest source of gravity in the universe. That honor now falls to dark energy, a more uniform source of repulsive gravity that seems to now dominate the expansion of the entire universe.   Not only Halloween: Today is Dark Matter Day.",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/DarkMatter_KipacAmnh_1200.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/DarkMatter_KipacAmnh_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "65C4B85E-513B-43A9-A7F9-8CA2EFA095C8",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 657244800,
                                                         "title": "A Rorschach Aurora",
                                                         "date": "2021-10-30",
                                                         "explanation": "If you see this as a monster's face, don't panic. It's only pareidolia, often experienced as the tendency to see faces in patterns of light and shadow. In fact, the startling visual scene is actually a 180 degree panorama of Northern Lights, digitally mirrored like inkblots on a folded piece of paper. Frames used to construct it were captured on a September night from the middle of a waterfall-crossing suspension bridge in Jamtland, Sweden. With geomagnetic storms triggered by recent solar activity, auroral displays could be very active at planet Earth's high latitudes in the coming days. But if you see a monster's face in your own neighborhood tomorrow night, it might just be Halloween.",
                                                         "copyright": "Göran Strand",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/GS_20210917_Handol_5651_Pan.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/GS_20210917_Handol_5651_Pan1024.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "515DC909-55BD-45D4-BA4E-54B8F40CA872",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 657158400,
                                                         "title": "Haunting the Cepheus Flare",
                                                         "date": "2021-10-29",
                                                         "explanation": "Spooky shapes seem to haunt this dusty expanse, drifting through the night in the royal constellation Cepheus. Of course, the shapes are cosmic dust clouds visible in dimly reflected starlight. Far from your own neighborhood, they lurk above the plane of the Milky Way at the edge of the Cepheus Flare molecular cloud complex some 1,200 light-years away. Over 2 light-years across and brighter than most of the other ghostly apparitions, vdB 141 or Sh2-136 is also known as the Ghost Nebula, seen at the right of the starry field of view. Inside the nebula are the telltale signs of dense cores collapsing in the early stages of star formation. With the eerie hue of dust reflecting bluish light from hot young stars of NGC 7023, the Iris Nebula stands out against the dark just left of center. In the broad telescopic frame, these fertile interstellar dust fields stretch almost seven full moons across the sky.",
                                                         "copyright": "Leo Shatz",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/IrisGhost_LeoShatz_RevB.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/IrisGhost_LeoShatz_RevB1024.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "8D1C0C21-CD55-4B27-B6E2-7537FE59CB81",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 657072000,
                                                         "title": "Mirach's Ghost",
                                                         "date": "2021-10-28",
                                                         "explanation": "As far as ghosts go, Mirach's Ghost isn't really that scary. Mirach's Ghost is just a faint, fuzzy galaxy, well known to astronomers, that happens to be seen nearly along the line-of-sight to Mirach, a bright star. Centered in this star field, Mirach is also called Beta Andromedae. About 200 light-years distant, Mirach is a red giant star, cooler than the Sun but much larger and so intrinsically much brighter than our parent star. In most telescopic views, glare and diffraction spikes tend to hide things that lie near Mirach and make the faint, fuzzy galaxy look like a ghostly internal reflection of the almost overwhelming starlight. Still, appearing in this sharp image just above and to the right of Mirach, Mirach's Ghost is cataloged as galaxy NGC 404 and is estimated to be some 10 million light-years away.",
                                                         "copyright": "John Chumack",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/Mirach_NGC404ChumackHRweb.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/Mirach_NGC404ChumackHRweb1024c.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "C9E41AC0-9106-4787-BC5A-4097B7DB1A0F",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 656985600,
                                                         "title": "NGC 6995: The Bat Nebula",
                                                         "date": "2021-10-27",
                                                         "explanation": "Do you see the bat?  It haunts this cosmic close-up of the eastern Veil Nebula.  The Veil Nebula itself is a large supernova remnant, the expanding debris cloud from the death explosion of a massive star. While the Veil is roughly circular in shape and covers nearly 3 degrees on the sky toward the constellation of the Swan (Cygnus), NGC 6995, known informally as the Bat Nebula, spans only 1/2 degree, about the apparent size of the Moon. That translates to 12 light-years at the Veil's estimated distance, a reassuring 1,400 light-years from planet Earth. In the composite of image data recorded through narrow band filters, emission from hydrogen atoms in the remnant is shown in red with strong emission from oxygen atoms shown in hues of blue. Of course, in the western part of the Veil lies another seasonal apparition: the Witch's Broom Nebula.   Explore Your Universe: Random APOD Generator",
                                                         "copyright": "Howard Trottier",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/Bat6995_Trottier_3449.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/Bat6995_Trottier_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "video",
                                                         "id": "1DCEC7B5-016C-490F-A1C2-381C1E28AE97",
                                                         "thumbnailUrl": "https://img.youtube.com/vi/QSXgDiS2H_A/0.jpg",
                                                         "postedDate": 656899200,
                                                         "title": "Jupiter Rotates",
                                                         "date": "2021-10-26",
                                                         "explanation": "Observe the graceful twirl of our Solar System's largest planet. Many interesting features of Jupiter's enigmatic atmosphere, including dark belts and light zones, can be followed in detail. A careful inspection will reveal that different cloud layers rotate at slightly different speeds. The famous Great Red Spot is not visible at first -- but soon rotates into view. Other smaller storm systems occasionally appear. As large as Jupiter is, it rotates in only 10 hours. Our small Earth, by comparison, takes 24 hours to complete a spin cycle. The featured high-resolution time-lapse video was captured over five nights earlier this month by a mid-sized telescope on an apartment balcony in Paris, France.  Since hydrogen and helium gas are colorless, and those elements compose most of Jupiter's expansive atmosphere, what trace elements create the observed colors of Jupiter's clouds remains a topic of research.    Discovery + Outreach: Graduate student research position open for APOD",
                                                         "copyright": "JL Dauvergne Music:",
                                                         "hdurl": null,
                                                         "url": "https://www.youtube.com/embed/QSXgDiS2H_A?rel=0"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "0A7BEB72-178A-408F-AE3C-469890456697",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 656812800,
                                                         "title": "Road to the Galactic Center",
                                                         "date": "2021-10-25",
                                                         "explanation": "Does the road to our galaxy's center go through Monument Valley? It doesn't have to, but if your road does -- take a picture. In this case, the road is US Route 163 and iconic buttes on the Navajo National Reservation populate the horizon.  The band of Milky Way Galaxy stretches down from the sky and appears to be a continuation of the road on Earth. Filaments of dust darken the Milky Way, in contrast to billions of bright stars and several colorful glowing gas clouds including the Lagoon and Trifid nebulas. The featured picture is a composite of images taken with the same camera and from the same location -- Forest Gump Point in Utah, USA. The foreground was taken just after sunset in early September during the blue hour, while the background is a mosaic of four exposures captured a few hours later.    Discovery + Outreach: Graduate student research position open for APOD",
                                                         "copyright": "Michael Abramyan",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/MonumentValleyRoad_Abramyan_2048.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/MonumentValleyRoad_Abramyan_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "22B9A1DE-4FD3-4CE4-9159-D027DBB113E5",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 656726400,
                                                         "title": "Halloween and the Ghost Head Nebula",
                                                         "date": "2021-10-24",
                                                         "explanation": "Halloween's origin is ancient and astronomical.  Since the fifth century BC, Halloween has been celebrated as a cross-quarter day, a day halfway between an equinox (equal day / equal night) and a solstice (minimum day / maximum night in the northern hemisphere).  With a modern calendar however, even though Halloween occurs next week, the real cross-quarter day will occur the week after.  Another cross-quarter day is Groundhog Day. Halloween's modern celebration retains historic roots in dressing to scare away the spirits of the dead.  Perhaps a fitting tribute to this ancient holiday is this view of the Ghost Head Nebula taken with the Hubble Space Telescope.  Similar to the icon of a fictional ghost, NGC 2080 is actually a star forming region in the Large Magellanic Cloud, a satellite galaxy of our own Milky Way Galaxy.  The Ghost Head Nebula (NGC 2080) spans about 50 light-years and is shown in representative colors.",
                                                         "copyright": null,
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/ngc2080_hubble_1348.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/ngc2080_hubble_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "710AFDBD-0D7F-4848-B049-51E1060C89C3",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 656640000,
                                                         "title": "3D Bennu",
                                                         "date": "2021-10-23",
                                                         "explanation": "Put on your red/blue glasses and float next to asteroid 101955 Bennu. Shaped like a spinning toy top with boulders littering its rough surface, the tiny Solar System world is about one Empire State Building (less than 500 meters) across. Frames used to construct this 3D anaglyph were taken by PolyCam on the OSIRIS_REx spacecraft on December 3, 2018 from a distance of about 80 kilometers. With a sample from the asteroid's rocky surface on board, OSIRIS_REx departed Bennu's vicinity this May and is now enroute to planet Earth. The robotic spacecraft is scheduled to return the sample to Earth in September 2023.",
                                                         "copyright": null,
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/ana03BennuVantuyne1465c.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/ana03BennuVantuyne1024c.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "7DF80A67-EB6B-4C35-B5DE-71B8CA5FD52D",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 656553600,
                                                         "title": "A Comet and a Crab",
                                                         "date": "2021-10-22",
                                                         "explanation": "This pretty field of view spans over 2 degrees or 4 full moons on the sky, filled with stars toward the constellation Taurus, the Bull. Above and right of center in the frame you can spot the faint fuzzy reddish appearance of Messier 1 (M1), also known as the Crab Nebula. M1 is the first object in 18th century comet hunter Charles Messier's famous catalog of things which are definitely not comets. Made from image data captured this October 11, there is a comet in the picture though. Below center and left lies the faint greenish coma and dusty tail of periodic comet 67P Churyumov-Gerasimenko, also known as Rosetta's comet. In the 21st century, it became the final resting place of robots from planet Earth. Rosetta's comet is now returning to the inner solar system, sweeping toward its next perihelion or closest approach to the Sun, on November 2. Too faint to be seen by eye alone, the comet's next perigee or closest approach to Earth will be November 12.",
                                                         "copyright": "Jose Mtanous",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/67p_m1_vdb47.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/67p_m1_vdb47_1024.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "557A2B25-0E1A-4C3D-B17B-15C3F5A7944E",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 656467200,
                                                         "title": "SH2-308: The Dolphin-head Nebula",
                                                         "date": "2021-10-21",
                                                         "explanation": "Blown by fast winds from a hot, massive star, this cosmic bubble is huge. Cataloged as Sharpless 2-308 it lies some 5,000 light-years away toward the constellation of the Big Dog (Canis Major) and covers slightly more of the sky than a Full Moon. That corresponds to a diameter of 60 light-years at its estimated distance. The massive star that created the bubble, a Wolf-Rayet star, is the bright one near the center of the nebula. Wolf-Rayet stars have over 20 times the mass of the Sun and are thought to be in a brief, pre-supernova phase of massive star evolution. Fast winds from this Wolf-Rayet star create the bubble-shaped nebula as they sweep up slower moving material from an earlier phase of evolution. The windblown nebula has an age of about 70,000 years. Relatively faint emission captured by narrowband filters in the deep image is dominated by the glow of ionized oxygen atoms mapped to a blue hue. Presenting a mostly harmless outline, SH2-308 is also known as The Dolphin-head Nebula.",
                                                         "copyright": "Nik Szymanek",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/SH2-308NS.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/SH2-308NS_1024.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "EC14C78B-23B2-48BE-BA76-1BF26F82B433",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 656380800,
                                                         "title": "Lucy Launches to Eight Asteroids",
                                                         "date": "2021-10-20",
                                                         "explanation": "Why would this mission go out as far as Jupiter -- but then not visit Jupiter? Lucy's plan is to follow different leads about the origin of our Solar System than can be found at Jupiter -- where Juno now orbits. Jupiter is such a massive planet that its gravity captures numerous asteroids that orbit the Sun ahead of it -- and behind. These trojan asteroids formed all over our Solar System and some may have been trapped there for billions of years. Flying by these trojan asteroids enables studying them as fossils that likely hold unique clues about our early Solar System. Lucy, named after a famous fossil skeleton which was named after a famous song, is scheduled to visit eight asteroids from 2025 to 2033.  Pictured, Lucy's launch was captured with reflection last week aboard a powerful Atlas V rocket from Cape Canaveral, Florida, USA.",
                                                         "copyright": "John Kraus",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/LucyLaunchB_Kraus_2048.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/LucyLaunchB_Kraus_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "92E581C8-C58A-4F9C-8B19-13221CACB533",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 656294400,
                                                         "date": "2021-10-19",
                                                         "title": "Palomar 6: Globular Star Cluster",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/Palomar6_Hubble_2529.jpg",
                                                         "explanation": "Where did this big ball of stars come from? Palomar 6 is one of about 200 globular clusters of stars that survive in our Milky Way Galaxy. These spherical star-balls are older than our Sun as well as older than most stars that orbit in our galaxy's disk.  Palomar 6 itself is estimated to be about 12.5 billion years old, so old that it is close to -- and so constrains -- the age of the entire universe.  Containing about 500,000 stars, Palomar 6 lies about 25,000 light years away, but not very far from our galaxy's center.  At that distance, this sharp image from the Hubble Space Telescope spans about 15 light-years.  After much study including images from Hubble, a leading origin hypothesis is that Palomar 6 was created -- and survives today -- in the central bulge of stars that surround the Milky Way's center, not in the distant galactic halo where most other globular clusters are now found.",
                                                         "copyright": null,
                                                         "url": "https://apod.nasa.gov/apod/image/2110/Palomar6_Hubble_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "thumbnailUrl": null,
                                                         "id": "937196CD-C290-46DE-9A03-9F2EAEA36F58",
                                                         "postedDate": 656208000,
                                                         "title": "Earthshine Moon over Sicily",
                                                         "copyright": "\nDario Giannobile",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/EarthshineSky_Giannobile_1212.jpg",
                                                         "explanation": "Why can we see the entire face of this Moon?  When the Moon is in a crescent phase, only part of it appears directly illuminated by the Sun.  The answer is earthshine, also known as earthlight and the da Vinci glow.  The reason is that the rest of the Earth-facing Moon is slightly illuminated by sunlight first reflected from the Earth.  Since the Earth appears near full phase from the Moon -- when the Moon appears as a slight crescent from the Earth -- earthshine is then near its brightest.  Featured here in combined, consecutively-taken, HDR images taken earlier this month, a rising earthshine Moon was captured passing slowly near the planet Venus, the brightest spot near the image center.  Just above Venus is the star Dschubba (catalogued as Delta Scorpii), while the red star on the far left is Antares. The celestial show is visible through scenic cloud decks. In the foreground are the lights from Palazzolo Acreide, a city with ancient historical roots in Sicily, Italy.",
                                                         "date": "2021-10-18",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/EarthshineSky_Giannobile_1212.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "thumbnailUrl": null,
                                                         "id": "BF353818-5E8B-480E-A179-16893E55D5BF",
                                                         "postedDate": 656121600,
                                                         "title": "The Einstein Cross Gravitational Lens",
                                                         "copyright": null,
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/qso2237_wiyn_1024.jpg",
                                                         "explanation": "Most galaxies have a single nucleus -- does this galaxy have four?  The strange answer leads astronomers to conclude that the nucleus of the surrounding galaxy is not even visible in this image.  The central cloverleaf is rather light emitted from a background quasar.  The gravitational field of the visible foreground galaxy breaks light from this distant quasar into four distinct images.  The quasar must be properly aligned behind the center of a massive galaxy for a mirage like this to be evident.  The general effect is known as gravitational lensing, and this specific case is known as the Einstein Cross.  Stranger still, the images of the Einstein Cross vary in relative brightness, enhanced occasionally by the additional gravitational microlensing effect of specific stars in the foreground galaxy.",
                                                         "date": "2021-10-17",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/qso2237_wiyn_1024.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "thumbnailUrl": null,
                                                         "id": "F5441962-0796-4825-B494-C32710EC18F1",
                                                         "postedDate": 656035200,
                                                         "title": "The Moona Lisa",
                                                         "copyright": "Gianni Sarcone",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/Moonalisa_base_corr.jpg",
                                                         "explanation": "Only natural colors of the Moon in planet Earth's sky appear in this creative visual presentation. Arranged as pixels in a framed image, the lunar disks were photographed at different times. Their varying hues are ultimately due to reflected sunlight affected by changing atmospheric conditions and the alignment geometry of Moon, Earth, and Sun. Here, the darkest lunar disks are the colors of earthshine. A description of earthshine, in terms of sunlight reflected by Earth's oceans illuminating the Moon's dark surface, was written over 500 years ago by Leonardo da Vinci.  But stand farther back from your monitor or just shift your gaze to the smaller versions of the image. You might also see one of da Vinci's most famous works of art.  Tonight: International Observe the Moon Night",
                                                         "date": "2021-10-16",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/Moonalisa_Example1024.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "thumbnailUrl": null,
                                                         "id": "5CAF9DB4-1DDA-4690-9546-D4E2DD8685CC",
                                                         "postedDate": 655948800,
                                                         "date": "2021-10-15",
                                                         "title": "NGC 289: Swirl in the Southern Sky",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/NGC289Selby.jpg",
                                                         "explanation": "About 70 million light-years distant, gorgeous spiral galaxy NGC 289 is larger than our own Milky Way. Seen nearly face-on, its bright core and colorful central disk give way to remarkably faint, bluish spiral arms. The extensive arms sweep well over 100 thousand light-years from the galaxy's center. At the lower right in this sharp, telescopic galaxy portrait the main spiral arm seems to encounter a small, fuzzy elliptical companion galaxy interacting with enormous NGC 289. Of course spiky stars are in the foreground of the scene. They lie within the Milky Way toward the southern constellation Sculptor.",
                                                         "copyright": "Mike Selby",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/NGC289Selby1024.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "thumbnailUrl": null,
                                                         "id": "720E6B8F-2671-46D2-8D5A-E9CC19BAA872",
                                                         "postedDate": 655862400,
                                                         "copyright": "Ignacio Diaz Bobillo",
                                                         "date": "2021-10-14",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/Helix_Oxygen_crop2.jpg",
                                                         "explanation": "A mere seven hundred light years from Earth, toward the constellation Aquarius, a sun-like star is dying. Its last few thousand years have produced the Helix Nebula (NGC 7293), a well studied and nearby example of a Planetary Nebula, typical of this final phase of stellar evolution.  A total of 90 hours of exposure time have gone in to creating this expansive view of the nebula. Combining narrow band image data from emission lines of hydrogen atoms in red and oxygen atoms in blue-green hues, it shows remarkable details of the Helix's brighter inner region about 3 light-years across. The white dot at the Helix's center is this Planetary Nebula's hot, central star. A simple looking nebula at first glance, the Helix is now understood to have a surprisingly complex geometry.",
                                                         "title": "NGC 7293: The Helix Nebula",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/Helix_Oxygen_crop2_1024.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "thumbnailUrl": null,
                                                         "id": "B6CF530A-0B28-48D3-AC12-78FAFB8F282A",
                                                         "postedDate": 655776000,
                                                         "copyright": "Yizhou Zhang",
                                                         "date": "2021-10-13",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2110/NGC7822_Yizhou_4044.jpg",
                                                         "explanation": "It may look like a huge cosmic question mark, but the big question really is  how does the bright gas and dark dust tell this nebula's history of star formation.  At the edge of a giant molecular cloud toward the northern constellation Cepheus, the glowing star forming region NGC 7822 lies about 3,000 light-years away. Within the nebula, bright edges and dark shapes stand out in this colorful and detailed skyscape. The 9-panel mosaic, taken over 28 nights with a small telescope in Texas, includes data from narrowband filters, mapping emission from atomic oxygen, hydrogen, and sulfur into blue, green, and red hues. The emission line and color combination has become well-known as the Hubble palette. The atomic emission is powered by energetic radiation from the central hot stars. Their powerful winds and radiation sculpt and erode the denser pillar shapes and clear out a characteristic cavity light-years across the center of the natal cloud. Stars could still be forming inside the pillars by gravitational collapse but as the pillars are eroded away, any forming stars will ultimately be cut off from their reservoir of star stuff. This field of view spans over 40 light-years across at the estimated distance of NGC 7822.",
                                                         "title": "NGC 7822: Cosmic Question Mark",
                                                         "url": "https://apod.nasa.gov/apod/image/2110/NGC7822_Yizhou_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "thumbnailUrl": null,
                                                         "id": "670198AD-20B5-4DE2-8EF5-BB0FD7954F6A",
                                                         "postedDate": 650505600,
                                                         "copyright": null,
                                                         "date": "2021-08-13",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2108/m74_APOD.jpg",
                                                         "explanation": "If not perfect then this spiral galaxy is at least one of the most photogenic. An island universe of about 100 billion stars, 32 million light-years away toward the constellation Pisces, M74 presents a gorgeous face-on view. Classified as an Sc galaxy, the grand design of M74's graceful spiral arms are traced by bright blue star clusters and dark cosmic dust lanes. This sharp composite was constructed from image data recorded by the Hubble Space Telescope's Advanced Camera for Surveys. Spanning about 30,000 light-years across the face of M74, it includes exposures recording emission from hydrogen atoms, highlighting the reddish glow of the galaxy's large star-forming regions. With a lower surface brightness than most galaxies in the Messier catalog, M74 is sometimes known as the Phantom Galaxy.   Notable APOD Image Submissions: Perseid Meteor Shower 2021",
                                                         "title": "A Perfect Spiral",
                                                         "url": "https://apod.nasa.gov/apod/image/2108/m74_APOD1024.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "thumbnailUrl": null,
                                                         "id": "3DE517B6-5F4F-4054-B5B5-538E7BBEFD61",
                                                         "postedDate": 650419200,
                                                         "copyright": "Mike Selby",
                                                         "date": "2021-08-12",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2108/M20-SHO-crop-Rev-5-RGB-Ha-OIII-RiDK-700-19-July-2021.jpg",
                                                         "explanation": "The beautiful Trifid Nebula is a cosmic study in contrasts. Also known as M20, it lies about 5,000 light-years away toward the nebula rich constellation Sagittarius. A star forming region in the plane of our galaxy, the Trifid does illustrate three different types of astronomical nebulae; red emission nebulae dominated by light from hydrogen atoms, blue reflection nebulae produced by dust reflecting starlight, and dark nebulae where dense dust clouds appear in silhouette. But the red emission region roughly separated into three parts by obscuring dust lanes is what lends the Trifid its popular name. Pillars and jets sculpted by newborn stars, below and left of the emission nebula's center, appear in famous Hubble Space Telescope close-up images of the region. The Trifid Nebula is about 40 light-years across. Just too faint to be seen by the unaided eye, it almost covers the area of a full moon in planet Earth's sky.",
                                                         "title": "A Beautiful Trifid",
                                                         "url": "https://apod.nasa.gov/apod/image/2108/M20-SHO-crop-Rev-5-RGB-Ha-OIII-RiDK-700-19-July-2021-1024.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "thumbnailUrl": null,
                                                         "id": "CAE7D9CA-06E2-47AA-9838-E434C0390D27",
                                                         "postedDate": 650332800,
                                                         "copyright": "Michael F Johnston",
                                                         "date": "2021-08-11",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2108/Mammatus_Johnston_2136.jpg",
                                                         "explanation": "When do cloud bottoms appear like bubbles? Normally, cloud bottoms are flat. This is because moist warm air that rises and cools will condense into water droplets at a specific temperature, which usually corresponds to a very specific height.  As water droplets grow, an opaque cloud forms.  Under some conditions, however, cloud pockets can develop that contain large droplets of water or ice that fall into clear air as they evaporate.  Such pockets may occur in turbulent air near a thunderstorm.  Resulting mammatus clouds can appear especially dramatic if sunlit from the side.  The mammatus clouds pictured here, lasting only a few minutes, were photographed over Regina, Saskatchewan, Canada, just after a storm in 2012.    Meteor Shower Tonight: Peak of the Perseids",
                                                         "title": "Mammatus Clouds over Saskatchewan",
                                                         "url": "https://apod.nasa.gov/apod/image/2108/Mammatus_Johnston_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "thumbnailUrl": null,
                                                         "id": "489E13A4-6E13-4420-9B53-CA861A618709",
                                                         "postedDate": 650246400,
                                                         "copyright": null,
                                                         "date": "2021-08-10",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2108/SpaceFlame_nasa_1100.jpg",
                                                         "explanation": "What does fire look like in space? In the gravity on Earth, heated air rises and expands, causing flames to be teardrop shaped. In the microgravity of the air-filled International Space Station (ISS), however, flames are spheres. Fire is the rapid acquisition of oxygen, and space flames meet new oxygen molecules when they float by randomly from all directions -- creating the enveloping sphere.  In the featured image taken in the ISS's Combustion Integration Rack, a spherical flame envelopes clusters of hot glowing soot.  Without oxygen, say in the vacuum of empty space, a fire would go out immediately.  The many chemical reactions involved with fire are complex, and testing them in microgravity is helping humanity not only to better understand fire -- but how to put out fire, too.",
                                                         "title": "Fire in Space",
                                                         "url": "https://apod.nasa.gov/apod/image/2108/SpaceFlame_nasa_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "thumbnailUrl": null,
                                                         "id": "419376D9-F6F0-4999-A561-28D5FBD19BC7",
                                                         "postedDate": 650160000,
                                                         "copyright": "Tomas SlovinskySlovakiaPetr HoralekCzech RepublicInstitute of Physics in Opava",
                                                         "date": "2021-08-09",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2108/PerseidsLost_SlovinskyHoralek_2048.jpg",
                                                         "explanation": "What's the best way to watch a meteor shower?  This question might come up later this week when the annual Perseid Meteor Shower peaks. One thing that is helpful is a dark sky, as demonstrated in the featured composite image of last year's Perseids.  Many more faint meteors are visible on the left image, taken through a very dark sky in Slovakia, than on the right image, taken through a moderately dark sky in the Czech Republic.  The band of the Milky Way Galaxy bridges the two coordinated images, while the meteor shower radiant in the constellation of Perseus is clearly visible on the left. In sum, many faint meteors are lost through a bright sky. Light pollution is shrinking areas across our Earth with dark skies, although inexpensive ways to combat this might be implemented.    Notable Perseids Submissions to APOD: 2018, 2019, 2020",
                                                         "title": "Perseus and the Lost Meteors",
                                                         "url": "https://apod.nasa.gov/apod/image/2108/PerseidsLost_SlovinskyHoralek_1080.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "thumbnailUrl": null,
                                                         "id": "6FA8D1A0-7A8A-4B0B-A3C8-0455DFE2E8DA",
                                                         "postedDate": 650073600,
                                                         "copyright": null,
                                                         "date": "2021-08-08",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2108/perseid_iss_4256.jpg",
                                                         "explanation": "rthlings typically watch meteor showers by looking up. But this remarkable view, captured on August 13, 2011 by astronaut Ron Garan, caught a Perseid meteor by looking down. From Garan's perspective onboard the International Space Station orbiting at an altitude of about 380 kilometers, the Perseid meteors streak below, swept up dust left from comet Swift-Tuttle heated to incandescence. The glowing comet dust grains are traveling at about 60 kilometers per second through the denser atmosphere around 100 kilometers above Earth's surface. In this case, the foreshortened meteor flash is right of frame center, below the curving limb of the Earth and a layer of greenish airglow, just below bright star Arcturus. Want to look up at a meteor shower?  You're in luck, as the 2021 Perseids meteor shower peaks this week. This year, even relatively faint meteors should be visible through clear skies from a dark location as the bright Moon will mostly absent.   Notable Perseids Submissions to APOD: 2018, 2019, 2020",
                                                         "title": "A Perseid Below",
                                                         "url": "https://apod.nasa.gov/apod/image/2108/perseid_iss_1080.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "thumbnailUrl": null,
                                                         "id": "EF793E53-7CEC-42B1-93F8-74B8373531DF",
                                                         "postedDate": 649987200,
                                                         "copyright": null,
                                                         "date": "2021-08-07",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2108/PIA24688_RTE_Anaglyph.jpg",
                                                         "explanation": "Get out your red-blue glasses and hover over the surface of Mars. Taken on July 24, the 3D color view is from the Mars Ingenuity Helicopter's 10th flight above the Red Planet. Two images from Ingenuity's color camera, both captured at an altitude of 12 meters (40 feet), but a few meters apart to provide a stereo perspective, were used to construct the color anaglyph. Ingenuity's stereo images were made at the request of the Mars Perseverance rover science team. The team is considering a visit to these raised ridges on the floor of Jezero Crater during Perseverance's first science campaign.",
                                                         "title": "Jezero Crater: Raised Ridges in 3D",
                                                         "url": "https://apod.nasa.gov/apod/image/2108/PIA24688_RTE_Anaglyph1024.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "28809BFC-ECA8-4BE7-835A-85AC00E88513",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 649900800,
                                                         "date": "2021-08-06",
                                                         "copyright": "Vikas Chander",
                                                         "explanation": "Cosmic dust clouds cross a rich field of stars in this telescopic vista near the northern boundary of Corona Australis, the Southern Crown. Less than 500 light-years away the dust clouds effectively block light from more distant background stars in the Milky Way. Top to bottom the frame spans about 2 degrees or over 15 light-years at the clouds' estimated distance. At top right is a group of lovely reflection nebulae cataloged as NGC 6726, 6727, 6729, and IC 4812. A characteristic blue color is produced as light from hot stars is reflected by the cosmic dust. The dust also obscures from view stars in the region still in the process of formation. Just above the bluish reflection nebulae a smaller NGC 6729 surrounds young variable star R Coronae Australis. To its right are telltale reddish arcs and loops identified as Herbig Haro objects associated with energetic newborn stars. Magnificent globular star cluster NGC 6723 is at bottom left in the frame. Though NGC 6723 appears to be part of the group, its ancient stars actually lie nearly 30,000 light-years away, far beyond the young stars of the Corona Australis dust clouds.",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2108/NGC6726_6723_2panel.jpg",
                                                         "title": "Stars and Dust Across Corona Australis",
                                                         "url": "https://apod.nasa.gov/apod/image/2108/NGC6726_6723_2panel1100.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "thumbnailUrl": null,
                                                         "id": "EAF40A01-E572-415C-8DB5-FE9E76DE2D0D",
                                                         "title": "Tycho and Clavius",
                                                         "date": "2021-08-05",
                                                         "copyright": "Eduardo Schaberger Poupeau",
                                                         "explanation": "South is up in this detailed telescopic view across the Moon's rugged southern highlands. Captured on July 20, the lunar landscape features the Moon's young and old, the large craters Tycho and Clavius. About 100 million years young, Tycho is the sharp-walled 85 kilometer diameter crater near center, its 2 kilometer tall central peak in bright sunlight and dark shadow. Debris ejected during the impact that created Tycho still make it the stand out lunar crater when the Moon is near full, producing a highly visible radiating system of light streaks, bright rays that extend across much of the lunar near side. In fact, some of the material collected at the Apollo 17 landing site, about 2,000 kilometers away, likely originated from the Tycho impact.  One of the oldest and largest craters on the Moon's near side, 225 kilometer diameter Clavius is due south (above) of Tycho. Clavius crater's own ray system resulting from its original impact event would have faded long ago. The old crater's worn walls and smooth floor are now overlayed by smaller craters from impacts that occurred after Clavius was formed. Observations by the Stratospheric Observatory for Infrared Astronomy (SOFIA) published in 2020 found water at Clavius. Of course both young Tycho and old Clavius craters are lunar locations in the science fiction epic 2001: A Space Odyssey.",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2108/Luna-Tycho-Clavius-high.jpg",
                                                         "postedDate": 649814400,
                                                         "url": "https://apod.nasa.gov/apod/image/2108/Luna-Tycho-Clavius-high1024.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "25C24F57-1248-4E7D-8E11-B63B412B3F53",
                                                         "thumbnailUrl": null,
                                                         "title": "EHT Resolves Central Jet from Black Hole in Cen A",
                                                         "copyright": null,
                                                         "date": "2021-08-04",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2108/CenAjets_Eht_3001.jpg",
                                                         "explanation": "How do supermassive black holes create powerful jets? To help find out, the Event Horizon Telescope (EHT) imaged the center of the nearby active galaxy Centaurus A.  The cascade of featured inset images shows Cen A from it largest, taking up more sky than many moons, to its now finest, taking up only as much sky as an golf ball on the moon. The new image shows what may look like two jets -- but is actually two sides of a single jet.  This newly discovered jet-edge brightening does not solve the jet-creation mystery, but does imply that the particle outflow is confined by a strong pressure -- possibly involving a magnetic field.  The EHT is a coordination of radio telescopes from around the Earth -- from the Caltech Submillimeter Observatory in Hawaii USA, to ALMA in Chile, to NOEMA in France, and more. The EHT will continue to observe massive, nearby black holes and their energetic surroundings.",
                                                         "postedDate": 649728000,
                                                         "url": "https://apod.nasa.gov/apod/image/2108/CenAjets_Eht_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "8A1FE8F3-307A-47DF-BE2B-6DDAA1507F13",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 649641600,
                                                         "date": "2021-08-03",
                                                         "title": "A Perseid Fireball and the Milky Way",
                                                         "explanation": "It was bright and green and flashed as it moved quickly along the Milky Way. It left a trail that took 30 minutes to dissipate.  Given the day, August 12, and the direction, away from Perseus, it was likely a small bit from the nucleus of Comet Swift-Tuttle plowing through the Earth's atmosphere -- and therefore part of the annual Perseids meteor shower.  The astrophotographer captured the fireball as it shot across the sky in 2018 above a valley in Yichang, Hubei, China. The meteor's streak, also caught on video, ended near the direction of Mars on the lower left. Next week, the 2021 Perseids meteor shower will peak again.  This year the Moon will set shortly after the Sun, leaving a night sky ideal for seeing lots of Perseids from dark and clear locations across planet Earth.   Follow APOD in English on: Facebook,  Instagram, or Twitter",
                                                         "copyright": "Dandan Huang",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2108/PerseusFireball_Dandan_1125.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2108/PerseusFireball_Dandan_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "video",
                                                         "id": "7B70AAA6-7446-4B84-A0A8-BC4A692B9026",
                                                         "thumbnailUrl": "",
                                                         "postedDate": 649555200,
                                                         "date": "2021-08-02",
                                                         "title": "The Hubble Ultra Deep Field in Light and Sound",
                                                         "explanation": "Have you heard about the Hubble Ultra-Deep Field?  Either way, you've likely not heard about it like this -- please run your cursor over the featured image and listen!  The Hubble Ultra-Deep Field (HUDF) was created in 2003-2004 with the Hubble Space Telescope staring for a long time toward near-empty space so that distant, faint galaxies would become visible.  One of the most famous images in astronomy, the HUDF is featured here in a vibrant way -- with sonified distances. Pointing to a galaxy will play a note that indicates its approximate redshift. Because redshifts shift light toward the red end of the spectrum of light, they are depicted here by a shift of tone toward the low end of the spectrum of sound.  The further the galaxy, the greater its cosmological redshift (even if it appears blue), and the lower the tone that will be played. The average galaxy in the HUDF is about 10.6 billion light years away and sounds like an F#. What's the most distant galaxy you can find?   Note: Sounds will only play on some browsers.  This week at NASA: Hubble #DeepFieldWeek",
                                                         "copyright": null,
                                                         "hdurl": null,
                                                         "url": "https://apod.nasa.gov/apod/image/1803/AstroSoM/hudf.html"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "6403924D-78BC-44F2-9866-9BD560D10E89",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 649468800,
                                                         "date": "2021-08-01",
                                                         "title": "Pluto in Enhanced Color",
                                                         "explanation": "Pluto is more colorful than we can see. Color data and high-resolution images of our Solar System's most famous dwarf planet, taken by the robotic New Horizons spacecraft during its flyby in 2015 July, have been digitally combined to give an enhanced-color view of this ancient world sporting an unexpectedly young surface. The featured enhanced color image is not only esthetically pretty but scientifically useful, making surface regions of differing chemical composition visually distinct. For example, the light-colored heart-shaped Tombaugh Regio on the lower right is clearly shown here to be divisible into two regions that are geologically different, with the leftmost lobe Sputnik Planitia also appearing unusually smooth. After Pluto, New Horizons continued on, shooting  past asteroid Arrokoth in 2019 and has enough speed to escape our Solar System completely.    Pluto-Related Images with Brief Explanations: APOD Pluto Search",
                                                         "copyright": null,
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2108/PlutoEnhancedHiRes_NewHorizons_5000.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2108/PlutoEnhancedHiRes_NewHorizons_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "491F24AC-F74A-477F-B1BE-A63647238848",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 648345600,
                                                         "date": "2021-07-19",
                                                         "title": "Framed by Trees: A Window to the Galaxy",
                                                         "explanation": "The photographer had this shot in mind for some time. He knew that objects overhead are the brightest -- since their light is scattered the least by atmospheric air. He also that knew the core of our Milky Way Galaxy was just about straight up near midnight around this time of year in South Australia.  Chasing his mental picture, he ventured deep inside the Kuipto Forest where tall radiata pines blocked out much of the sky -- but not in this clearing.  There, through a window framed by trees, he captured his envisioned combination of local and distant nature. Sixteen exposures of both trees and the Milky Way Galaxy were recorded. Antares is the bright orange star to left of our Galaxy's central plane, while Alpha Centauri is the bright star just to the right of the image center.  The direction toward our Galaxy's center is below Antares.  Although in a few hours the Earth's rotation moved the Galactic plane up and to the left -- soon invisible behind the timber, his mental image was secured forever -- and is featured here.    Follow APOD on Instagram in: English, Farsi, Indonesian, Persian, Portuguese or Taiwanese",
                                                         "copyright": "Will Godward",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2107/ForestWindow_Godward_2236.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2107/ForestWindow_Godward_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "4D1ED3A6-6D80-4DDD-8A1F-4E9C8520F7B4",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 647481600,
                                                         "date": "2021-07-09",
                                                         "title": "M82: Starburst Galaxy with a Superwind",
                                                         "explanation": "M82 is a starburst galaxy with a superwind. In fact, through ensuing supernova explosions and powerful winds from massive stars, the burst of star formation in M82 is driving a prodigious outflow. Evidence for the superwind from the galaxy's central regions is clear in sharp telescopic snapshot. The composite image highlights emission from long outflow filaments of atomic hydrogen gas in reddish hues. Some of the gas in the superwind, enriched in heavy elements forged in the massive stars, will eventually escape into intergalactic space. Triggered by a close encounter with nearby large galaxy M81, the furious burst of star formation in M82 should last about 100 million years or so. Also known as the Cigar Galaxy for its elongated visual appearance, M82 is about 30,000 light-years across. It lies 12 million light-years away near the northern boundary of Ursa Major.",
                                                         "copyright": "Team ARO",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2107/LRVBPIX3M82Crop.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2107/LRVBPIX3M82Crop1024.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "ADC242DF-489D-4ED9-9816-264B0E2ADAD2",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 647395200,
                                                         "date": "2021-07-08",
                                                         "title": "Perihelion to Aphelion",
                                                         "explanation": "Aphelion for 2021 occurred on July 5th. That's the point in Earth's elliptical orbit when it is farthest from the Sun. Of course, the distance from the Sun doesn't determine the seasons. Those are governed by the tilt of Earth's axis of rotation, so July is still summer in the north and winter in the southern hemisphere. But it does mean that on July 5 the Sun was at its smallest apparent size when viewed from planet Earth. This composite neatly compares two pictures of the Sun, both taken with the same telescope and camera. The left half was captured close to the date of the 2021 perihelion (January 2), the closest point in Earth's orbit. The right was recorded just before the aphelion in 2021. Otherwise difficult to notice, the change in the Sun's apparent diameter between perihelion and aphelion amounts to a little over 3 percent.",
                                                         "copyright": "Richard Jaworski",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2107/PeriAph2021_Jaworski.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2107/PeriAph2021_Jaworski1024.jpg"
                                                     },
                                                     {
                                                         "mediaType": "video",
                                                         "id": "C2F04F34-54BB-40EE-94BF-3E3831C83D47",
                                                         "thumbnailUrl": "https://img.youtube.com/vi/ix1lzur2QLQ/0.jpg",
                                                         "postedDate": 647308800,
                                                         "date": "2021-07-07",
                                                         "title": "Flight Through the Orion Nebula in Infrared Light",
                                                         "explanation": "What would it look like to fly into the Orion Nebula?  The exciting dynamic visualization of the Orion Nebula is based on real astronomical data and adept movie rendering techniques. Up close and personal with a famous stellar nursery normally seen from 1,500 light-years away, the digitally modeled representation based is based on infrared data from the Spitzer Space Telescope. The perspective moves along a valley over a light-year wide, in the wall of the region's giant molecular cloud. Orion's valley ends in a cavity carved by the energetic winds and radiation of the massive central stars of the Trapezium star cluster. The entire Orion Nebula spans about 40 light years and is located in the same spiral arm of our Galaxy as the Sun.",
                                                         "copyright": null,
                                                         "hdurl": null,
                                                         "url": "https://www.youtube.com/embed/ix1lzur2QLQ?rel=0"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "FB750236-835A-42D9-A559-0D607AA43A5F",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 647222400,
                                                         "date": "2021-07-06",
                                                         "title": "Saturn and Six Moons",
                                                         "explanation": "How many moons does Saturn have? So far 82 have been confirmed, the smallest being only a fraction of a kilometer across. Six of its largest satellites can be seen here in a composite image with 13 short exposure of the bright planet, and 13 long exposures of the brightest of its faint moons, taken over two weeks last month.  Larger than Earth's Moon and even slightly larger than Mercury,Saturn's largest moon Titan has a diameter of 5,150 kilometers and was captured making nearly a complete orbit around its ringed parent planet.  Saturn's first known natural satellite, Titan was discovered in 1655 by Dutch astronomer Christiaan Huygens, in contrast with several newly discovered moons announced in 2019.  The trail on the far right belongs to Iapetus, Saturn's third largest moon. The radius of painted Iapetus' orbit is so large that only a portion of it was captured here. Saturn leads Jupiter across the night sky this month, rising soon after sunset toward the southeast, and remaining visible until dawn.",
                                                         "copyright": "Mohammad Ranjbaran MR Thanks: Amir Ehteshami",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2107/SaturnAndMoons_Ranjbaran_2692.jpg",
                                                         "url": "https://apod.nasa.gov/apod/image/2107/SaturnAndMoons_Ranjbaran_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "D02AABC0-CB6B-4AB3-9E83-06982CB307EE",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 647136000,
                                                         "title": "IC 4592: The Blue Horsehead Reflection Nebula",
                                                         "copyright": "Adam BlockSteward Observatory,\nUniversity of Arizona",
                                                         "explanation": "Do you see the horse's head?   What you are seeing is not the famous Horsehead nebula toward Orion but rather a fainter nebula that only takes on a familiar form with deeper imaging.  The main part of the here imaged molecular cloud complex is a reflection nebula cataloged as IC 4592.  Reflection nebulas are actually made up of very fine dust that normally appears dark but can look quite blue when reflecting the visible light of energetic nearby stars.  In this case, the source of much of the reflected light is a star at the eye of the horse.  That star is part of Nu Scorpii, one of the brighter star systems toward the constellation of the Scorpion (Scorpius).   A second reflection nebula dubbed IC 4601 is visible surrounding two stars to the right of the image center.   Almost Hyperspace: Random APOD Generator",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2107/ic4592_block_2132.jpg",
                                                         "date": "2021-07-05",
                                                         "url": "https://apod.nasa.gov/apod/image/2107/ic4592_block_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "8942A935-9941-431A-A6D6-68F3B36BD117",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 647049600,
                                                         "copyright": null,
                                                         "date": "2021-07-04",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2107/MartianFace_Viking_960.jpg",
                                                         "explanation": "Wouldn't it be fun if clouds were castles?  Wouldn't it be fun if the laundry on the bedroom chair was a superhero?  Wouldn't it be fun if rock mesas on Mars were interplanetary monuments to the human face?  Clouds, though, are floating droplets of water and ice.  Laundry is cotton, wool, or plastic, woven into garments.  Famous Martian rock mesas known by names like the Face on Mars appear quite natural when seen more clearly on better images.  Is reality boring? Nobody knows why some clouds make rain.  Nobody knows if life ever developed on Mars.  Nobody knows why the laundry on the bedroom chair smells like root beer.  Scientific exploration can not only resolve mysteries, but uncover new knowledge, greater mysteries, and yet deeper questions.  As humanity explores our universe, perhaps fun -- through discovery --  is just beginning.",
                                                         "title": "The Face on Mars",
                                                         "url": "https://apod.nasa.gov/apod/image/2107/MartianFace_Viking_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "C10CC0C9-0C26-4BD3-B0B1-F8CD86839424",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 646963200,
                                                         "copyright": "Rolf Weisenfeld",
                                                         "date": "2021-07-03",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2107/Walk_Milkyway.jpg",
                                                         "explanation": "You can't walk along the Milky Way. Still, under a dark sky you can explore it. To the eye the pale luminous trail of light arcing through the sky on a dark, moonless night does appear to be a path through the heavens. The glowing celestial band is the faint, collective light of distant stars cut by swaths of obscuring interstellar dust clouds. It lies along the plane of our home galaxy, so named because it looks like a milky way. Since Galileo's time, the Milky Way has been revealed to telescopic skygazers to be filled with congeries of innumerable stars and cosmic wonders.",
                                                         "title": "Along the Milky Way",
                                                         "url": "https://apod.nasa.gov/apod/image/2107/Walk_Milkyway_1024.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "22F15F0B-B86F-4FCB-9915-DDA5EBD577CC",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 646876800,
                                                         "copyright": "Michael\nTeoh",
                                                         "date": "2021-07-02",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2107/AR2835_20210701_W2x.jpg",
                                                         "explanation": "Awash in a sea of incandescent plasma and anchored in strong magnetic fields, sunspots are planet-sized dark islands in the solar photosphere, the bright surface of the Sun. Found in solar active regions, sunspots look dark only because they are slightly cooler though, with temperatures of about 4,000 kelvins compared to 6,000 kelvins for the surrounding solar surface. These sunspots lie in active region AR2835. The largest active region now crossing the Sun, AR2835 is captured in this sharp telescopic close-up from July 1 in a field of view that spans about 150,000 kilometers or over ten Earth diameters. With powerful magnetic fields, solar active regions are often responsible for solar flares and coronal mass ejections, storms which affect space weather near planet Earth.",
                                                         "title": "AR2835: Islands in the Photosphere",
                                                         "url": "https://apod.nasa.gov/apod/image/2107/AR2835_20210701_W2x1024.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "52BA6E82-04B8-42D6-A0AA-A3E47C0D307A",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 646790400,
                                                         "copyright": null,
                                                         "date": "2021-07-01",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2107/PIA24542_fig2.jpg",
                                                         "explanation": "On sol 46 (April 6, 2021) the Perseverance rover held out a robotic arm to take its first selfie on Mars. The WATSON camera at the end of the arm was designed to take close-ups of martian rocks and surface details though, and not a quick snap shot of friends and smiling faces. In the end, teamwork and weeks of planning on Mars time was required to program a complex series of exposures and camera motions to include Perseverance and its surroundings. The resulting 62 frames were composed into a detailed mosiac, one of the most complicated Mars rover selfies ever taken. In this version of the selfie, the rover's Mastcam-Z and SuperCam instruments are looking toward WATSON and the end of the rover's outstretched arm. About 4 meters (13 feet) from Perseverance is a robotic companion, the Mars Ingenuity helicopter.",
                                                         "title": "Perseverance Selfie with Ingenuity",
                                                         "url": "https://apod.nasa.gov/apod/image/2107/PIA24542_fig2_1100c.jpg"
                                                     },
                                                     {
                                                         "mediaType": "video",
                                                         "thumbnailUrl": "https://img.youtube.com/vi/q9ZCBR-onRw/0.jpg",
                                                         "id": "39BA4DB3-B441-4D99-B2E2-E6CC3AD4501C",
                                                         "postedDate": 646704000,
                                                         "title": "Simulation: Formation of the First Stars",
                                                         "copyright": null,
                                                         "explanation": "How did the first stars form? To help find out, the SPHINX computer simulation of star formation in the very early universe was created, some results of which are shown in the featured video. Time since the Big Bang is shown in millions of years on the upper left.  Even 100 million years after the Big Bang, matter was spread too uniformly across the cosmos for stars to be born.  Besides background radiation, the universe was dark. Soon, slight matter clumps rich in hydrogen gas begin to coalesce into the first stars. In the time-lapse video, purple denotes gas, white denotes light, and gold shows radiation so energetic that it ionizes hydrogen, breaking it up into charged electrons and protons.  The gold-colored regions also track the most massive stars that die with powerful supernovas. The inset circle highlights a central region that is becoming a galaxy.  The simulation continues until the universe was about 550 million years old.  To assess the accuracy of the SPHINX simulations and the assumptions that went into them, the results are not only being compared to current deep observations, but will also be compared with more direct observations of the early universe planned with NASA's pending James Webb Space Telescope.",
                                                         "date": "2021-06-30",
                                                         "hdurl": null,
                                                         "url": "https://www.youtube.com/embed/q9ZCBR-onRw?rel=0"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "thumbnailUrl": null,
                                                         "id": "802A1571-B4F1-4634-8A6B-3B78D4703BF2",
                                                         "postedDate": 646617600,
                                                         "title": "Orion Nebula: The Hubble View",
                                                         "copyright": null,
                                                         "explanation": "Few cosmic vistas excite the imagination like the Orion Nebula. Also known as M42, the nebula's glowing gas surrounds hot young stars at the edge of an immense interstellar molecular cloud only 1,500 light-years away. The Orion Nebula offers one of the best opportunities to study how stars are born partly because it is the nearest large star-forming region, but also because the nebula's energetic stars have blown away obscuring gas and dust clouds that would otherwise block our view - providing an intimate look at a range of ongoing stages of starbirth and evolution. The featured image of the Orion Nebula is among the sharpest ever, constructed using data from the Hubble Space Telescope.  The entire Orion Nebula spans about 40 light years and is located in the same spiral arm of our Galaxy as the Sun.",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2106/OrionNebula_HubbleSerrano_2362.jpg",
                                                         "date": "2021-06-29",
                                                         "url": "https://apod.nasa.gov/apod/image/2106/OrionNebula_HubbleSerrano_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "76C0BEB5-FE37-4821-B9F2-3E45F7E20CC2",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 645062400,
                                                         "copyright": "Zev Hoover",
                                                         "title": "Eclipse Flyby",
                                                         "explanation": "On June 10 a New Moon passed in front of the Sun. In silhouette only two days after reaching apogee, the most distant point in its elliptical orbit, the Moon's small apparent size helped create an annular solar eclipse. The brief but spectacular annular phase of the eclipse shows a bright solar disk as a ring of fire when viewed along its narrow, northerly shadow track across planet Earth. Cloudy early morning skies along the US east coast held gorgeous views of a partially eclipsed Sun though. Rising together Moon and Sun are captured in a sequence of consecutive frames near maximum eclipse in this digital composite, seen from Quincy Beach south of Boston, Massachusetts. The serendipitous sequence follows the undulating path of a bird in flight joining the Moon in silhouette with the rising Sun.   Notable images submitted to APOD: This week's solar eclipse",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2106/2021-06-10EclipseFlybywm.jpg",
                                                         "date": "2021-06-11",
                                                         "url": "https://apod.nasa.gov/apod/image/2106/2021-06-10EclipseFlybywm1066.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "B673EC1C-9CAC-47AD-ABF6-8A88FD1A0057",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 644716800,
                                                         "copyright": "Chuck Ayoub",
                                                         "title": "A Bright Nova in Cassiopeia",
                                                         "explanation": "What’s that new spot of light in Cassiopeia? A nova.  Although novas occur frequently throughout the universe, this nova, known as Nova Cas 2021 or V1405 Cas, became so unusually bright in the skies of Earth last month that it was visible to the unaided eye.  Nova Cas 2021 first brightened in mid-March but then, unexpectedly, became even brighter in mid-May and remained quite bright for about a week.  The nova then faded back to early-May levels,  but now is slightly brightening again and remains visible through binoculars.  Identified by the arrow, the nova occurred toward the constellation of Cassiopeia, not far from the Bubble Nebula.  A nova is typically caused by a thermonuclear explosion on the surface of a white dwarf star that is accreting matter from a binary-star companion -- although details of this outburst are currently unknown.  Novas don't destroy the underlying star, and are sometimes seen to recur.  The featured image was created from 14 hours of imaging from Detroit, Michigan, USA.  Both professional and amateur astronomers will likely continue to monitor Nova Cas 2021 and hypothesize about details of its cause.",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2106/NovaCasAndFriends_Ayoub_2230.jpg",
                                                         "date": "2021-06-07",
                                                         "url": "https://apod.nasa.gov/apod/image/2106/NovaCasAndFriends_Ayoub_960.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "140A9DFF-021E-4294-919E-EB529E39BC9E",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 644630400,
                                                         "copyright": "Elias Chasiotis",
                                                         "title": "A Distorted Sunrise Eclipse",
                                                         "explanation": "Yes, but have you ever seen a sunrise like this?  Here, after initial cloudiness, the Sun appeared to rise in two pieces and during partial eclipse, causing the photographer to describe it as the most stunning sunrise of his life.  The dark circle near the top of the atmospherically-reddened Sun is the Moon -- but so is the dark peak just below it.  This is because along the way, the Earth's atmosphere had an inversion layer of unusually warm air which acted like a gigantic lens and created a second image.  For a normal sunrise or sunset, this rare phenomenon of atmospheric optics is known as the Etruscan vase effect. The featured picture was captured in December 2019 from Al Wakrah, Qatar.  Some observers in a narrow band of Earth to the east were able to see a full annular solar eclipse -- where the Moon appears completely surrounded by the background Sun in a ring of fire.  The next solar eclipse, also an annular eclipse for well-placed observers, will occur later this week on  June 10.",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2106/DistortedSunrise_Chasiotis_2442.jpg",
                                                         "date": "2021-06-06",
                                                         "url": "https://apod.nasa.gov/apod/image/2106/DistortedSunrise_Chasiotis_1080.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "BDE7C322-56E1-4C5E-8518-C05F266BDED9",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 644544000,
                                                         "copyright": null,
                                                         "title": "The Shining Clouds of Mars",
                                                         "explanation": "The weathered and layered face of Mount Mercou looms in the foreground of this mosaic from the Curiosity Mars rover's Mast Camera. Made up of 21 individual images the scene was recorded just after sunset on March 19, the 3,063rd martian day of Curiosity's on going exploration of the Red Planet. In the martian twilight high altitude clouds still shine above, reflecting the light from the Sun below the local horizon like the noctilucent clouds of planet Earth. Though water ice clouds drift through the thin martian atmosphere, these wispy clouds are also at extreme altitudes and could be composed of frozen carbon dioxide, crystals of dry ice. Curiosity's Mast Cam has also imaged iridescent or mother of pearl clouds adding subtle colors to the martian sky.",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2106/PIA24622-Curiosity_Clouds_Mont_Mercou.jpg",
                                                         "date": "2021-06-05",
                                                         "url": "https://apod.nasa.gov/apod/image/2106/PIA24622-Curiosity_Clouds_Mont_Mercou1100.jpg"
                                                     },
                                                     {
                                                         "mediaType": "image",
                                                         "id": "470774DC-0EA2-4437-A4AF-61A78D8F04C3",
                                                         "thumbnailUrl": null,
                                                         "postedDate": 644457600,
                                                         "date": "2021-06-04",
                                                         "copyright": "Chirag Upreti",
                                                         "explanation": "On May 26, the Full Flower Moon was caught in this single exposure as it emerged from Earth's shadow and morning twilight began to wash over the western sky. Posing close to the horizon near the end of totality, an eclipsed lunar disk is framed against bare oak trees at Pinnacles National Park in central California. The Earth's shadow isn't completely dark though. Faintly suffused with sunlight scattered by the atmosphere, the inner shadow gives the totally eclipsed moon a reddened appearance and the very dramatic popular moniker of a Blood Moon. Still, the monstrous visage of a gnarled tree in silhouette made this view of a total lunar eclipse even scarier.",
                                                         "hdurl": "https://apod.nasa.gov/apod/image/2106/Lunareclipse_PinnaclesNationalPark.jpg",
                                                         "title": "Blood Monster Moon",
                                                         "url": "https://apod.nasa.gov/apod/image/2106/Lunareclipse_PinnaclesNationalPark1024.jpg"
                                                     }
                                                 ]
                                             """
}

