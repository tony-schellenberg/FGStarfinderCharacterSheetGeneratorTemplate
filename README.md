# Starfinder Template for Fantasy Grounds Universal Character Sheet Printer
This repo is for a template to be used with the Fantasy Grounds Universal Character Sheet Printer.
The printer binaries and details can be found here: https://www.fantasygrounds.com/forums/showthread.php?27390-Universal-Character-Sheet-Printer-for-FG

# Templating with Xalan
This xsl template can be used with the universal character printer or another templating system like `xalan`.
Here's some useful commands that were used as part of building this out:

In order to use `xalan` to produce a web page, export your character and use the command line something like this:
```shell
xalan -html -in <ExportedCharacterFile>.xml -xsl CharacterSheet_Starfinder.xsl -out <OutputFilename>.html
```

# Tricks and Gotchas
### Page Layout
The layout is done primarily with the use of `div` tags plus some styling.
For the second section, flex boxes are used so that the space fills a little more nicely.

### Page Break Hints and Background Images
For printing purposes, page break hints are provided for each of the sections so that it should split nicely most of the time.
The background images on each of the sections is marked to indicate that they should be printed even when background image printing is not used.

### Embedded Images
All of the images are dynamically generated through CSS or SVG.

# Inspiration
Initial xsl inspiration from:
* https://www.fantasygrounds.com/forums/showthread.php?27390-Universal-Character-Sheet-Printer-for-FG&p=485349&viewfull=1#post485349

Space background inspiration from:
* https://css-tricks.com/drawing-realistic-clouds-with-svg-and-css/
* https://projects.verou.me/css3patterns/#starry-night
* https://codepen.io/NazarTheVis/pen/zqXMqP
* https://stackoverflow.com/questions/7324722/cut-corners-using-css