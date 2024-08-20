#!/bin/bash

set -eo pipefail

IMAGES=(
    "https://lh4.googleusercontent.com/-e9NHZ5k5MSs/URqvMIBZjtI/AAAAAAAAAbs/1fV810rDNfQ/XXX/Yosemite%252520Tree.jpg"
    "https://lh6.googleusercontent.com/-55osAWw3x0Q/URquUtcFr5I/AAAAAAAAAbs/rWlj1RUKrYI/XXX/A%252520Photographer.jpg"
    "https://lh4.googleusercontent.com/--dq8niRp7W4/URquVgmXvgI/AAAAAAAAAbs/-gnuLQfNnBA/XXX/A%252520Song%252520of%252520Ice%252520and%252520Fire.jpg"
    "https://lh5.googleusercontent.com/-7qZeDtRKFKc/URquWZT1gOI/AAAAAAAAAbs/hqWgteyNXsg/XXX/Another%252520Rockaway%252520Sunset.jpg"
    "https://lh3.googleusercontent.com/--L0Km39l5J8/URquXHGcdNI/AAAAAAAAAbs/3ZrSJNrSomQ/XXX/Antelope%252520Butte.jpg"
    "https://lh6.googleusercontent.com/-8HO-4vIFnlw/URquZnsFgtI/AAAAAAAAAbs/WT8jViTF7vw/XXX/Antelope%252520Hallway.jpg"
    "https://lh4.googleusercontent.com/-WIuWgVcU3Qw/URqubRVcj4I/AAAAAAAAAbs/YvbwgGjwdIQ/XXX/Antelope%252520Walls.jpg"
    "https://lh6.googleusercontent.com/-UBmLbPELvoQ/URqucCdv0kI/AAAAAAAAAbs/IdNhr2VQoQs/XXX/Apre%2525CC%252580s%252520la%252520Pluie.jpg"
    "https://lh3.googleusercontent.com/-s-AFpvgSeew/URquc6dF-JI/AAAAAAAAAbs/Mt3xNGRUd68/XXX/Backlit%252520Cloud.jpg"
    "https://lh5.googleusercontent.com/-bvmif9a9YOQ/URquea3heHI/AAAAAAAAAbs/rcr6wyeQtAo/XXX/Bee%252520and%252520Flower.jpg"
    "https://lh5.googleusercontent.com/-n7mdm7I7FGs/URqueT_BT-I/AAAAAAAAAbs/9MYmXlmpSAo/XXX/Bonzai%252520Rock%252520Sunset.jpg"
    "https://lh6.googleusercontent.com/-4CN4X4t0M1k/URqufPozWzI/AAAAAAAAAbs/8wK41lg1KPs/XXX/Caterpillar.jpg"
    "https://lh3.googleusercontent.com/-rrFnVC8xQEg/URqufdrLBaI/AAAAAAAAAbs/s69WYy_fl1E/XXX/Chess.jpg"
    "https://lh5.googleusercontent.com/-WVpRptWH8Yw/URqugh-QmDI/AAAAAAAAAbs/E-MgBgtlUWU/XXX/Chihuly.jpg"
    "https://lh5.googleusercontent.com/-0BDXkYmckbo/URquhKFW84I/AAAAAAAAAbs/ogQtHCTk2JQ/XXX/Closed%252520Door.jpg"
    "https://lh3.googleusercontent.com/-PyggXXZRykM/URquh-kVvoI/AAAAAAAAAbs/hFtDwhtrHHQ/XXX/Colorado%252520River%252520Sunset.jpg"
    "https://lh3.googleusercontent.com/-ZAs4dNZtALc/URquikvOCWI/AAAAAAAAAbs/DXz4h3dll1Y/XXX/Colors%252520of%252520Autumn.jpg"
    "https://lh4.googleusercontent.com/-GztnWEIiMz8/URqukVCU7bI/AAAAAAAAAbs/jo2Hjv6MZ6M/XXX/Countryside.jpg"
    "https://lh4.googleusercontent.com/-bEg9EZ9QoiM/URquklz3FGI/AAAAAAAAAbs/UUuv8Ac2BaE/XXX/Death%252520Valley%252520-%252520Dunes.jpg"
    "https://lh6.googleusercontent.com/-ijQJ8W68tEE/URqulGkvFEI/AAAAAAAAAbs/zPXvIwi_rFw/XXX/Delicate%252520Arch.jpg"
    "https://lh5.googleusercontent.com/-Oh8mMy2ieng/URqullDwehI/AAAAAAAAAbs/TbdeEfsaIZY/XXX/Despair.jpg"
    "https://lh5.googleusercontent.com/-gl0y4UiAOlk/URqumC_KjBI/AAAAAAAAAbs/PM1eT7dn4oo/XXX/Eagle%252520Fall%252520Sunrise.jpg"
    "https://lh3.googleusercontent.com/-hYYHd2_vXPQ/URqumtJa9eI/AAAAAAAAAbs/wAalXVkbSh0/XXX/Electric%252520Storm.jpg"
    "https://lh5.googleusercontent.com/-PyY_yiyjPTo/URqunUOhHFI/AAAAAAAAAbs/azZoULNuJXc/XXX/False%252520Kiva.jpg"
    "https://lh6.googleusercontent.com/-PYvLVdvXywk/URqunwd8hfI/AAAAAAAAAbs/qiMwgkFvf6I/XXX/Fitzgerald%252520Streaks.jpg"
    "https://lh4.googleusercontent.com/-KIR_UobIIqY/URquoCZ9SlI/AAAAAAAAAbs/Y4d4q8sXu4c/XXX/Foggy%252520Sunset.jpg"
    "https://lh6.googleusercontent.com/-9lzOk_OWZH0/URquoo4xYoI/AAAAAAAAAbs/AwgzHtNVCwU/XXX/Frantic.jpg"
    "https://lh3.googleusercontent.com/-0X3JNaKaz48/URqupH78wpI/AAAAAAAAAbs/lHXxu_zbH8s/XXX/Golden%252520Gate%252520Afternoon.jpg"
    "https://lh6.googleusercontent.com/-95sb5ag7ABc/URqupl95RDI/AAAAAAAAAbs/g73R20iVTRA/XXX/Golden%252520Gate%252520Fog.jpg"
    "https://lh3.googleusercontent.com/-JB9v6rtgHhk/URqup21F-zI/AAAAAAAAAbs/64Fb8qMZWXk/XXX/Golden%252520Grass.jpg"
    "https://lh4.googleusercontent.com/-EIBGfnuLtII/URquqVHwaRI/AAAAAAAAAbs/FA4McV2u8VE/XXX/Grand%252520Teton.jpg"
    "https://lh4.googleusercontent.com/-WoMxZvmN9nY/URquq1v2AoI/AAAAAAAAAbs/grj5uMhL6NA/XXX/Grass%252520Closeup.jpg"
    "https://lh3.googleusercontent.com/-6hZiEHXx64Q/URqurxvNdqI/AAAAAAAAAbs/kWMXM3o5OVI/XXX/Green%252520Grass.jpg"
    "https://lh5.googleusercontent.com/-6LVb9OXtQ60/URquteBFuKI/AAAAAAAAAbs/4F4kRgecwFs/XXX/Hanging%252520Leaf.jpg"
    "https://lh4.googleusercontent.com/-zAvf__52ONk/URqutT_IuxI/AAAAAAAAAbs/D_bcuc0thoU/XXX/Highway%2525201.jpg"
    "https://lh6.googleusercontent.com/-H4SrUg615rA/URquuL27fXI/AAAAAAAAAbs/4aEqJfiMsOU/XXX/Horseshoe%252520Bend%252520Sunset.jpg"
    "https://lh4.googleusercontent.com/-JhFi4fb_Pqw/URquuX-QXbI/AAAAAAAAAbs/IXpYUxuweYM/XXX/Horseshoe%252520Bend.jpg"
    "https://lh5.googleusercontent.com/-UGgssvFRJ7g/URquueyJzGI/AAAAAAAAAbs/yYIBlLT0toM/XXX/Into%252520the%252520Blue.jpg"
    "https://lh3.googleusercontent.com/-CH7KoupI7uI/URquu0FF__I/AAAAAAAAAbs/R7GDmI7v_G0/XXX/Jelly%252520Fish%2525202.jpg"
    "https://lh4.googleusercontent.com/-pwuuw6yhg8U/URquvPxR3FI/AAAAAAAAAbs/VNGk6f-tsGE/XXX/Jelly%252520Fish%2525203.jpg"
    "https://lh5.googleusercontent.com/-GoUQVw1fnFw/URquv6xbC0I/AAAAAAAAAbs/zEUVTQQ43Zc/XXX/Kauai.jpg"
    "https://lh6.googleusercontent.com/-8QdYYQEpYjw/URquwvdh88I/AAAAAAAAAbs/cktDy-ysfHo/XXX/Kyoto%252520Sunset.jpg"
    "https://lh4.googleusercontent.com/-vPeekyDjOE0/URquwzJ28qI/AAAAAAAAAbs/qxcyXULsZrg/XXX/Lake%252520Tahoe%252520Colors.jpg"
    "https://lh4.googleusercontent.com/-xBPxWpD4yxU/URquxWHk8AI/AAAAAAAAAbs/ARDPeDYPiMY/XXX/Lava%252520from%252520the%252520Sky.jpg"
    "https://lh3.googleusercontent.com/-897VXrJB6RE/URquxxxd-5I/AAAAAAAAAbs/j-Cz4T4YvIw/XXX/Leica%25252050mm%252520Summilux.jpg"
    "https://lh5.googleusercontent.com/-qSJ4D4iXzGo/URquyDWiJ1I/AAAAAAAAAbs/k2pBXeWehOA/XXX/Leica%25252050mm%252520Summilux.jpg"
    "https://lh6.googleusercontent.com/-dwlPg83vzLg/URquylTVuFI/AAAAAAAAAbs/G6SyQ8b4YsI/XXX/Leica%252520M8%252520%252528Front%252529.jpg"
    "https://lh3.googleusercontent.com/-R3_EYAyJvfk/URquzQBv8eI/AAAAAAAAAbs/b9xhpUM3pEI/XXX/Light%252520to%252520Sand.jpg"
    "https://lh3.googleusercontent.com/-fHY5h67QPi0/URqu0Cp4J1I/AAAAAAAAAbs/0lG6m94Z6vM/XXX/Little%252520Bit%252520of%252520Paradise.jpg"
    "https://lh5.googleusercontent.com/-TzF_LwrCnRM/URqu0RddPOI/AAAAAAAAAbs/gaj2dLiuX0s/XXX/Lone%252520Pine%252520Sunset.jpg"
    "https://lh3.googleusercontent.com/-4HdpJ4_DXU4/URqu046dJ9I/AAAAAAAAAbs/eBOodtk2_uk/XXX/Lonely%252520Rock.jpg"
    "https://lh6.googleusercontent.com/-erbF--z-W4s/URqu1ajSLkI/AAAAAAAAAbs/xjDCDO1INzM/XXX/Longue%252520Vue.jpg"
    "https://lh6.googleusercontent.com/-0CXJRdJaqvc/URqu1opNZNI/AAAAAAAAAbs/PFB2oPUU7Lk/XXX/Look%252520Me%252520in%252520the%252520Eye.jpg"
    "https://lh3.googleusercontent.com/-D_5lNxnDN6g/URqu2Tk7HVI/AAAAAAAAAbs/p0ddca9W__Y/XXX/Lost%252520in%252520a%252520Field.jpg"
    "https://lh6.googleusercontent.com/-flsqwMrIk2Q/URqu24PcmjI/AAAAAAAAAbs/5ocIH85XofM/XXX/Marshall%252520Beach%252520Sunset.jpg"
    "https://lh4.googleusercontent.com/-Y4lgryEVTmU/URqu28kG3gI/AAAAAAAAAbs/OjXpekqtbJ4/XXX/Mono%252520Lake%252520Blue.jpg"
    "https://lh4.googleusercontent.com/-AaHAJPmcGYA/URqu3PIldHI/AAAAAAAAAbs/lcTqk1SIcRs/XXX/Monument%252520Valley%252520Overlook.jpg"
    "https://lh4.googleusercontent.com/-vKxfdQ83dQA/URqu31Yq_BI/AAAAAAAAAbs/OUoGk_2AyfM/XXX/Moving%252520Rock.jpg"
    "https://lh5.googleusercontent.com/-CG62QiPpWXg/URqu4ia4vRI/AAAAAAAAAbs/0YOdqLAlcAc/XXX/Napali%252520Coast.jpg"
    "https://lh6.googleusercontent.com/-wdGrP5PMmJQ/URqu5PZvn7I/AAAAAAAAAbs/m0abEcdPXe4/XXX/One%252520Wheel.jpg"
    "https://lh6.googleusercontent.com/-6WS5DoCGuOA/URqu5qx1UgI/AAAAAAAAAbs/giMw2ixPvrY/XXX/Open%252520Sky.jpg"
    "https://lh6.googleusercontent.com/-u8EHKj8G8GQ/URqu55sM6yI/AAAAAAAAAbs/lIXX_GlTdmI/XXX/Orange%252520Sunset.jpg"
    "https://lh6.googleusercontent.com/-74Z5qj4bTDE/URqu6LSrJrI/AAAAAAAAAbs/XzmVkw90szQ/XXX/Orchid.jpg"
    "https://lh6.googleusercontent.com/-lEQE4h6TePE/URqu6t_lSkI/AAAAAAAAAbs/zvGYKOea_qY/XXX/Over%252520there.jpg"
    "https://lh5.googleusercontent.com/-cauH-53JH2M/URqu66v_USI/AAAAAAAAAbs/EucwwqclfKQ/XXX/Plumes.jpg"
    "https://lh3.googleusercontent.com/-eDLT2jHDoy4/URqu7axzkAI/AAAAAAAAAbs/iVZE-xJ7lZs/XXX/Rainbokeh.jpg"
    "https://lh5.googleusercontent.com/-j1NLqEFIyco/URqu8L1CGcI/AAAAAAAAAbs/aqZkgX66zlI/XXX/Rainbow.jpg"
    "https://lh5.googleusercontent.com/-DRnqmK0t4VU/URqu8XYN9yI/AAAAAAAAAbs/LgvF_592WLU/XXX/Rice%252520Fields.jpg"
    "https://lh3.googleusercontent.com/-hwh1v3EOGcQ/URqu8qOaKwI/AAAAAAAAAbs/IljRJRnbJGw/XXX/Rockaway%252520Fire%252520Sky.jpg"
    "https://lh5.googleusercontent.com/-wjV6FQk7tlk/URqu9jCQ8sI/AAAAAAAAAbs/RyYUpdo-c9o/XXX/Rockaway%252520Flow.jpg"
    "https://lh6.googleusercontent.com/-6cAXNfo7D20/URqu-BdzgPI/AAAAAAAAAbs/OmsYllzJqwo/XXX/Rockaway%252520Sunset%252520Sky.jpg"
    "https://lh3.googleusercontent.com/-sl8fpGPS-RE/URqu_BOkfgI/AAAAAAAAAbs/Dg2Fv-JxOeg/XXX/Russian%252520Ridge%252520Sunset.jpg"
    "https://lh6.googleusercontent.com/-gVtY36mMBIg/URqu_q91lkI/AAAAAAAAAbs/3CiFMBcy5MA/XXX/Rust%252520Knot.jpg"
    "https://lh6.googleusercontent.com/-GHeImuHqJBE/URqu_FKfVLI/AAAAAAAAAbs/axuEJeqam7Q/XXX/Sailing%252520Stones.jpg"
    "https://lh3.googleusercontent.com/-hBbYZjTOwGc/URqu_ycpIrI/AAAAAAAAAbs/nAdJUXnGJYE/XXX/Seahorse.jpg"
    "https://lh3.googleusercontent.com/-Iwi6-i6IexY/URqvAYZHsVI/AAAAAAAAAbs/5ETWl4qXsFE/XXX/Shinjuku%252520Street.jpg"
    "https://lh6.googleusercontent.com/-amhnySTM_MY/URqvAlb5KoI/AAAAAAAAAbs/pFCFgzlKsn0/XXX/Sierra%252520Heavens.jpg"
    "https://lh5.googleusercontent.com/-dJgjepFrYSo/URqvBVJZrAI/AAAAAAAAAbs/v-F5QWpYO6s/XXX/Sierra%252520Sunset.jpg"
    "https://lh4.googleusercontent.com/-Z4zGiC5nWdc/URqvBdEwivI/AAAAAAAAAbs/ZRZR1VJ84QA/XXX/Sin%252520Lights.jpg"
    "https://lh4.googleusercontent.com/-_0cYiWW8ccY/URqvBz3iM4I/AAAAAAAAAbs/9N_Wq8MhLTY/XXX/Starry%252520Lake.jpg"
    "https://lh3.googleusercontent.com/-A9LMoRyuQUA/URqvCYx_JoI/AAAAAAAAAbs/s7sde1Bz9cI/XXX/Starry%252520Night.jpg"
    "https://lh3.googleusercontent.com/-KtLJ3k858eY/URqvC_2h_bI/AAAAAAAAAbs/zzEBImwDA_g/XXX/Stream.jpg"
    "https://lh5.googleusercontent.com/-dFB7Lad6RcA/URqvDUftwWI/AAAAAAAAAbs/BrhoUtXTN7o/XXX/Strip%252520Sunset.jpg"
    "https://lh5.googleusercontent.com/-at6apgFiN20/URqvDyffUZI/AAAAAAAAAbs/clABCx171bE/XXX/Sunset%252520Hills.jpg"
    "https://lh4.googleusercontent.com/-7-EHhtQthII/URqvEYTk4vI/AAAAAAAAAbs/QSJZoB3YjVg/XXX/Tenaya%252520Lake%2525202.jpg"
    "https://lh6.googleusercontent.com/-8MrjV_a-Pok/URqvFC5repI/AAAAAAAAAbs/9inKTg9fbCE/XXX/Tenaya%252520Lake.jpg"
    "https://lh5.googleusercontent.com/-B1HW-z4zwao/URqvFWYRwUI/AAAAAAAAAbs/8Peli53Bs8I/XXX/The%252520Cave%252520BW.jpg"
    "https://lh3.googleusercontent.com/-PO4E-xZKAnQ/URqvGRqjYkI/AAAAAAAAAbs/42nyADFsXag/XXX/The%252520Fisherman.jpg"
    "https://lh4.googleusercontent.com/-iLyZlzfdy7s/URqvG0YScdI/AAAAAAAAAbs/1J9eDKmkXtk/XXX/The%252520Night%252520is%252520Coming.jpg"
    "https://lh6.googleusercontent.com/-G-k7YkkUco0/URqvHhah6fI/AAAAAAAAAbs/_taQQG7t0vo/XXX/The%252520Road.jpg"
    "https://lh6.googleusercontent.com/-h-ALJt7kSus/URqvIThqYfI/AAAAAAAAAbs/ejiv35olWS8/XXX/Tokyo%252520Heights.jpg"
    "https://lh5.googleusercontent.com/-Hy9k-TbS7xg/URqvIjQMOxI/AAAAAAAAAbs/RSpmmOATSkg/XXX/Tokyo%252520Highway.jpg"
    "https://lh6.googleusercontent.com/-83oOvMb4OZs/URqvJL0T7lI/AAAAAAAAAbs/c5TECZ6RONM/XXX/Tokyo%252520Smog.jpg"
    "https://lh3.googleusercontent.com/-FB-jfgREEfI/URqvJI3EXAI/AAAAAAAAAbs/XfyweiRF4v8/XXX/Tufa%252520at%252520Night.jpg"
    "https://lh4.googleusercontent.com/-vngKD5Z1U8w/URqvJUCEgPI/AAAAAAAAAbs/ulxCMVcU6EU/XXX/Valley%252520Sunset.jpg"
    "https://lh6.googleusercontent.com/-DOz5I2E2oMQ/URqvKMND1kI/AAAAAAAAAbs/Iqf0IsInleo/XXX/Windmill%252520Sunrise.jpg"
    "https://lh5.googleusercontent.com/-biyiyWcJ9MU/URqvKculiAI/AAAAAAAAAbs/jyPsCplJOpE/XXX/Windmill.jpg"
    "https://lh4.googleusercontent.com/-PDT167_xRdA/URqvK36mLcI/AAAAAAAAAbs/oi2ik9QseMI/XXX/Windmills.jpg"
    "https://lh5.googleusercontent.com/-kI_QdYx7VlU/URqvLXCB6gI/AAAAAAAAAbs/N31vlZ6u89o/XXX/Yet%252520Another%252520Rockaway%252520Sunset.jpg"
)

function main {
    local FORMAT="$1"
    [[ -n "$FORMAT" ]] || show_help_and_exit 64;

    local SIZE="${2/--/}"
    [[ -n $SIZE ]] && [[ $((SIZE=10#$SIZE)) -gt 0 ]] || show_help_and_exit 65;

    case "$FORMAT" in
        "--json")
            echo "Generating JSON: [$SIZE] x [$SIZE]"
            generate_json "s$SIZE" "images.json"
        ;;
        "--md")
            echo "Generating Markdown: [$SIZE] x [$SIZE]"
            generate_markdown "s$SIZE" "images.md"
        ;;
        "--help" | "-h" | *)
            show_help_and_exit 0
        ;;
    esac
}

function generate_json {
    local SIZE="$1"
    local FILE="$2"
    local JSON=

    for ((i=0; i < "${#IMAGES[@]}"; i++)); do
        JSON+=$(printf "{\"img_id\":%d,\"img_url\":\"%s\"}," "$((i+1))" "${IMAGES[$i]}")
    done
    JSON=$(echo "[${JSON[@]/%,/}]")
    echo "${JSON[@]//XXX/$SIZE}" | jq > "$FILE"
}

function generate_markdown {
    local SIZE="$1"
    local FILE="$2"
    local MD=

    for ((i=0; i < "${#IMAGES[@]}"; i++)); do
        MD+=$(printf "![img-%d](%s)\n\r" "$((i+1))" "${IMAGES[$i]}")
    done
    echo "${MD[@]//XXX/$SIZE}" > "$FILE"
}

function show_help_and_exit {
    echo -e
    echo -e "-h, --help - Print this help message and exit."
    echo -e
    echo -e "Usage:"
    echo -e
    echo -e "Example 1: - Generate json with 1024 resolution images."
    echo -e "\t\$ bash $0 --json --1024"
    echo -e
    echo -e "Example 2: - Generate markdown with 256 resolution images."
    echo -e "\t\$ bash $0 --md --256"
    echo -e
    echo -e "Format options:"
    echo -e "\t--json (JSON)"
    echo -e "\t--md (Markdown)"
    echo -e
    echo -e "Resolution options:"
    echo -e "\t--64, --128, --256, --512, --1024, --2048"
    echo -e
    echo -e "Errors:"
    echo -e "\t[64] - Missing or invalid format option."
    echo -e "\t[65] - Missing or invalid size option."
    echo -e

    exit $1
}

main $1 $2
