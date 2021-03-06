@echo off
setlocal
echo %1
IF [%1]==[] EXIT /B 1
IF NOT EXIST static\img\%1 EXIT /B
cd static\img\%1\original
set img=%2
if not defined img set img="main.jpg"
echo %img%
for /R %%U in (*.png) do echo %%U && magick mogrify -resize "1000>" -sampling-factor 4:2:0 -interlace Plane -transparent white -alpha remove -path .. -strip -quality 80 -format jpg %%U
for /R %%U in (*.png) do echo %%U && magick mogrify -resize "1000>" -sampling-factor 4:2:0 -interlace Plane -path .. -strip -quality 95 -format png %%U
for /R %%U in (*.jpg) do echo %%U && magick mogrify -resize "1000>" -sampling-factor 4:2:0 -interlace Plane -path .. -strip -quality 90 -format jpg %%U
for /R %%U in (*.jpeg) do echo %%U && magick mogrify -resize "1000>" -sampling-factor 4:2:0 -interlace Plane -path .. -strip -quality 90 -format jpg %%U
cd ..
rmdir thumbs
mkdir thumbs
magick %img% -sampling-factor 4:2:0 -strip -quality 80 -resize 255x175^^ -gravity center -interlace Plane -crop 255x175+0+0 +repage thumb_card.jpg
magick %img% -sampling-factor 4:2:0 -strip -quality 80 -resize 500x250^^ -gravity center -interlace Plane -crop 600x335+0+0 +repage thumb_fb.jpg
for /R %%U in (*.jpg) do echo %%U && magick mogrify -resize "16x16^" -sampling-factor 4:2:0 -format jpg -path thumbs -strip -quality 60 %%U

