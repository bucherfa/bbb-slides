# BBB Slides

## Usage
```bash
./main.sh <bbb slides url> [start slide] [end slide]
```

> script depends on curl, rsvg-convert and pdfunite

## Get presentation slides url

* in the bbb room must be a presentation slide present (no screen share)
* right-click on the current slide, and select `Copy Image Link` (Firefox)
* remove trailing number from url, that the url ends on `.../svg/`

## Notes

* url should end with a slash
* first slide has the index `1`
* start/end slide arguments are optional
* start slide argument but no end slide argument means starting at provided index and getting all slides after that
* generated pdf will appear as `out.pdf` next to the script

## Examples

```bash
# getting all slides
./main.sh wget https://example.com/bigbluebutton/presentation/<long id>/svg/

# getting the first 10 slides
./main.sh wget https://example.com/bigbluebutton/presentation/<long id>/svg/ 1 10

# getting all slides starting at slide 10
./main.sh wget https://example.com/bigbluebutton/presentation/<long id>/svg/ 10
```