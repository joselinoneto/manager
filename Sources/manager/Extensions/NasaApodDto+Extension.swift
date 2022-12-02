//
//  File.swift
//  
//
//  Created by José Neto on 27/11/2022.
//

import Foundation
import apiclient

extension NasaApodDto {
    public static var mockItems: [NasaApodDto] {
        var payload: String = mockPayLoad
        payload = payload.replacingOccurrences(of: "\n", with: "")
        guard let data: Data = payload.data(using: .utf8, allowLossyConversion: true) else { return [] }
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([NasaApodDto].self, from: data)
            return decodedData
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
                                                             "id": "30902C9E-6295-44A7-ADCD-AEE456760742",
                                                             "thumbnailUrl": null,
                                                             "postedDate": 1669372439,
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
                                                             "id": "8F7E8F99-CE50-41CC-99AE-06216B9CC008",
                                                             "postedDate": 1669372439,
                                                             "title": "Dark Matter in a Simulated Universe",
                                                             "copyright": "Tom AbelRalf KaehlerKIPACSLACAMNH",
                                                             "date": "2021-10-31",
                                                             "explanation": "Is our universe haunted?  It might look that way on this dark matter map.  The gravity of unseen dark matter is the leading explanation for why galaxies rotate so fast, why galaxies orbit clusters so fast, why gravitational lenses so strongly deflect light, and why visible matter is distributed as it is both in the local universe and on the cosmic microwave background.  The featured image from the American Museum of Natural History's Hayden Planetarium Space Show Dark Universe highlights one example of how pervasive dark matter might haunt our universe.  In this frame from a detailed computer simulation, complex filaments of dark matter, shown in black, are strewn about the universe like spider webs, while the relatively rare clumps of familiar baryonic matter are colored orange. These simulations are good statistical matches to astronomical observations.  In what is perhaps a scarier turn of events, dark matter -- although quite strange and in an unknown form -- is no longer thought to be the strangest source of gravity in the universe. That honor now falls to dark energy, a more uniform source of repulsive gravity that seems to now dominate the expansion of the entire universe.   Not only Halloween: Today is Dark Matter Day.",
                                                             "hdurl": "https://apod.nasa.gov/apod/image/2110/DarkMatter_KipacAmnh_1200.jpg",
                                                             "url": "https://apod.nasa.gov/apod/image/2110/DarkMatter_KipacAmnh_960.jpg"
                                                         },
                                                         {
                                                             "mediaType": "image",
                                                             "id": "A417B37C-53DC-4A1B-93A0-84CADF59DCB1",
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
                                                             "id": "B5F58275-097B-48F2-8E8F-7280EE498932",
                                                             "thumbnailUrl": null,
                                                             "postedDate": 657158400,
                                                             "title": "Haunting the Cepheus Flare",
                                                             "date": "2021-10-29",
                                                             "explanation": "Spooky shapes seem to haunt this dusty expanse, drifting through the night in the royal constellation Cepheus. Of course, the shapes are cosmic dust clouds visible in dimly reflected starlight. Far from your own neighborhood, they lurk above the plane of the Milky Way at the edge of the Cepheus Flare molecular cloud complex some 1,200 light-years away. Over 2 light-years across and brighter than most of the other ghostly apparitions, vdB 141 or Sh2-136 is also known as the Ghost Nebula, seen at the right of the starry field of view. Inside the nebula are the telltale signs of dense cores collapsing in the early stages of star formation. With the eerie hue of dust reflecting bluish light from hot young stars of NGC 7023, the Iris Nebula stands out against the dark just left of center. In the broad telescopic frame, these fertile interstellar dust fields stretch almost seven full moons across the sky.",
                                                             "copyright": "Leo Shatz",
                                                             "hdurl": "https://apod.nasa.gov/apod/image/2110/IrisGhost_LeoShatz_RevB.jpg",
                                                             "url": "https://apod.nasa.gov/apod/image/2110/IrisGhost_LeoShatz_RevB1024.jpg"
                                                         }
                                                     ]
                                                 """
}
