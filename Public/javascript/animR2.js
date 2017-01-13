// ------------------------------------
//  script to animate jpg or any other
// image type from separate image files
// 
// (c) eightize 2006
// modified:
//	June 10 2007	by: mb
//		changed preload to array, so not constantly re-loading from server
//	July 15 2006
// ------------------------------------
// To setup animations, add a script to the end of the page calling setupAnim()
//		All images must have different names, otherwise they will not animate
//			(set by name='imageName' in the <img> tag) 
//		Pass this information for each animation:
//			setupAnim(seconds between images,name of image,Array(list of images))

// initialise variables for animation
var animImages = new Array();
var thisImg = new Array();
var imgCt = new Array();
var imgSpd = new Array();
var preImage = new Array();

//  pass (speed in seconds between frames,name of image to animate,Array(list of images))
//	note: the current image coded into the page is added by the script to
//		the list of images, so don't include that image in the array.
function setupAnim(imgSpeed,imgName,imgList) {
	animImages[imgName] = imgList;
	var arrayLength = animImages[imgName].length;
	animImages[imgName][arrayLength] = document.images[imgName].src;
	thisImg[imgName] = 0;
	imgCt[imgName] = arrayLength + 1;
	imgSpd[imgName] = imgSpeed;
	preImage[imgName] = new Array();
	preImage[imgName][0] = new Image;
	preImage[imgName][0].src = animImages[imgName][0];
	uhrzeit(imgName);
	setTimeout("rotate('"+imgName+"')", imgSpeed * 1000);
	
	
}

function getUhrzeit(imgName)
{
	var datumUngeparst = document.images[imgName].src.replace("http://www.wetteronline.de/?ireq=true&pid=p_embeddedmaps&src=wmapsextract/vermarktung/wmaps2tiles/composite/landingpage_web/","").replace("/m3/0304.jpeg","");
			var datumArray = datumUngeparst.split("/"); 
			  var utcDate = new Date();
			  utcDate.setUTCFullYear(datumArray[0]);
			  utcDate.setUTCMonth(datumArray[1]-1);
			  utcDate.setUTCDate(datumArray[2]);
utcDate.setUTCHours(datumArray[3]);
utcDate.setUTCMinutes(datumArray[4]);
utcDate.setUTCSeconds(0);
return utcDate;
}

function uhrzeit(imgName)
{
	var utcDate = 		 getUhrzeit(imgName);

if (utcDate > new Date())
{
			   document.getElementById('uhrzeit').innerHTML=utcDate.toLocaleString()+ " Prognose ";

}
else
{
			   document.getElementById('uhrzeit').innerHTML=utcDate.toLocaleString() ;

}

}

function rotate(imgName) {
	if (document.images) {
		var curImg = thisImg[imgName];
		if (preImage[imgName][curImg].complete) {

			document.images[imgName].src=preImage[imgName][curImg].src;
		uhrzeit(imgName);
			// preload next image
			var nxtImg = ++thisImg[imgName];
			if (nxtImg == imgCt[imgName])
				nxtImg = thisImg[imgName] = 0;
			if (!preImage[imgName][nxtImg]) {
				preImage[imgName][nxtImg] = new Image;
				preImage[imgName][nxtImg].src = animImages[imgName][nxtImg];
			}
			var imgSpeed = imgSpd[imgName];
		} else { // not loaded yet;  check again 1/10 second
			var imgSpeed = 0.1;
		}
	  	setTimeout("rotate('"+imgName+"')", imgSpeed * 1000);
  	}
}
