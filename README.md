##### state of the Art OCR able to extract text from image can be improved to greater extent. 
##### purpose of the repo is to demonstrate the Working Model with Perl, [Tesseract](https://github.com/tesseract-ocr/tesseract),[imagemagick](https://imagemagick.org/index.php)

```
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install build-essential

#http://httpredir.debian.org/


#install cpanm
curl -L https://cpanmin.us | perl - --sudo App::cpanminus

sudo apt install tesseract-ocr
sudo apt install tesseract-ocr-all
sudo apt-get install imagemagick
sudo apt-get install imagemagick-*
sudo apt-get install libimage-magick-perl
sudo apt-get install perlmagick
sudo apt-get install libgd-dev

sudo cpanm File::Temp
sudo cpanm Image::OCR::Tesseract
sudo cpanm Image::Magick
sudo cpanm ExtUtils::PkgConfig
sudo cpanm GD
sudo cpanm Log::Log4perl
sudo cpanm Image::Magick::Info
sudo cpanm Image::Filter::Invert #test before implementing

sudo cpanm Image::Info;

https://app.vagrantup.com/s4mobile/boxes/debian-7.11-amd64/versions/1.0.1/providers/virtualboxa.box

```
#image 1
    # Check height and width
    # check if png
    # check regex matches


