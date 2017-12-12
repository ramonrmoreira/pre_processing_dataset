function Faces = Extract_faces(file_vid, file_eye_pos)


    fileID = fopen(file_eye_pos);
    eye_pos = textscan(fileID, '%d %d %d %d %d', 'Delimiter', ',');
	vid = VideoReader(file_vid);
	iframe = 0;
	Faces.flag = 0;

	%To detect Face
	FDetect = vision.CascadeObjectDetector;
	
	%To detect Left Eye
	LeftEyeDetect = vision.CascadeObjectDetector('LeftEye');
	
	%To detect Right Eye
	RightEyeDetect = vision.CascadeObjectDetector('RightEye');

	% config landmarks to Eyes and Mouth (4 and 5)
	landconf = 5;
	
	% config of landmarks Eyebrows (only 2)
	landconfEyebrow = 2;
	
	
	for iframe = 1:55

	
		% read the input image
		%I = readFrame(vid);
        A = readFrame(vid);
        
        if (eye_pos{2}(iframe) ~= 0 && eye_pos{3}(iframe) ~= 0 && eye_pos{4}(iframe) ~= 0 && eye_pos{5}(iframe) ~= 0)
            opposite = double(eye_pos{5}(iframe) - eye_pos{3}(iframe));
            adjacent = double(eye_pos{4}(iframe) - eye_pos{2}(iframe));
            angle_rotation = atand(opposite/adjacent);
            A = imrotate(A, angle_rotation);
        end
        
		I = rgb2ntsc(A);
		%I = imresize(I, [224,224]);
	
		[imgFace, LeftEye, RightEye, Mouth, LeftEyebrow,  RightEyebrow] = detectFacialRegions(I);
		[A, LeftEye, RightEye, Mouth, LeftEyebrow,  RightEyebrow] = detectFacialRegions(A);
	
	
		
		if imgFace(1,1) > 0
		if LeftEye(1,1) > 0
		if RightEye(1,1) > 0
		if Mouth(1,1) > 0
		if LeftEyebrow(1,1) > 0
		if RightEyebrow(1,1) > 0
            

			facesize = size(imgFace);
			k1lefteye = max(LeftEye(1,2):LeftEye(1,2)+LeftEye(1,4));
			k2lefteye = max(LeftEye(1,1):LeftEye(1,1)+LeftEye(1,3));
			k1righteye = max(RightEye(1,2):RightEye(1,2)+RightEye(1,4));
			k2righteye = max(RightEye(1,1):RightEye(1,1)+RightEye(1,3));
			k1mouth = max(Mouth(1,2):Mouth(1,2)+Mouth(1,4));
			k2mouth = max(Mouth(1,1):Mouth(1,1)+Mouth(1,3));
			k1lefteyebrow = max(LeftEyebrow(1,2):LeftEyebrow(1,2)+LeftEyebrow(1,4));
			k2lefteyebrow = max(LeftEyebrow(1,1):LeftEyebrow(1,1)+LeftEyebrow(1,3));
			k1righteyebrow = max(RightEyebrow(1,2):RightEyebrow(1,2)+RightEyebrow(1,4));
			k2righteyebrow = max(RightEyebrow(1,1):RightEyebrow(1,1)+RightEyebrow(1,3));

			if facesize(1) > k1lefteye && facesize(2) > k2lefteye
			if facesize(1) > k1righteye && facesize(2) > k2righteye
			if facesize(1) > k1mouth && facesize(2) > k2mouth
			if facesize(1) > k1lefteyebrow && facesize(2) > k2lefteyebrow
			if facesize(1) > k1righteyebrow && facesize(2) > k2righteyebrow

				%% landmarks the eyes
				imgLeftEye = (imgFace(LeftEye(1,2):LeftEye(1,2)+LeftEye(1,4),LeftEye(1,1):LeftEye(1,1)+LeftEye(1,3),:));
				[landLeftEye, leftEyeCont] = eyesProcessing(imgLeftEye,landconf);
            
				imgRightEye = (imgFace(RightEye(1,2):RightEye(1,2)+RightEye(1,4),RightEye(1,1):RightEye(1,1)+RightEye(1,3),:));
				[landRightEye, rightEyeCont] = eyesProcessing(imgRightEye,landconf);

				% landmarks the mouth
				imgMouth = (imgFace(Mouth(1,2):Mouth(1,2)+Mouth(1,4),Mouth(1,1):Mouth(1,1)+Mouth(1,3),:));
				[landMouth, MouthCont] = mouthProcessing(imgMouth,landconf);

				% landmarks the eyebrows
				imgLeftEyebrow = (imgFace(LeftEyebrow(1,2):LeftEyebrow(1,2)+LeftEyebrow(1,4),LeftEyebrow(1,1):LeftEyebrow(1,1)+LeftEyebrow(1,3),:));
				[landLeftEyebrow, leftEyebrowCont] = eyebrowsProcessing(imgLeftEyebrow,landconfEyebrow);

				imgRightEyebrow = (imgFace(RightEyebrow(1,2):RightEyebrow(1,2)+RightEyebrow(1,4),RightEyebrow(1,1):RightEyebrow(1,1)+RightEyebrow(1,3),:));
				[landRightEyebrow, RightEyebrowCont] = eyebrowsProcessing(imgRightEyebrow,landconfEyebrow);


				if MouthCont(1) == 0 && MouthCont(2) == 0
				MouthCont = [0 0 0];
				end
				if leftEyeCont(1) == 0 && leftEyeCont(2) == 0
				leftEyeCont = [0 0 0];
				end
				if rightEyeCont(1) == 0 && rightEyeCont(2) == 0
				rightEyeCont = [0 0 0];
				end
				if leftEyebrowCont(1) == 0 && leftEyebrowCont(2) == 0
				leftEyeCont = [0 0 0];
				end
				if RightEyebrowCont(1) == 0 && RightEyebrowCont(2) == 0
				RightEyeCont = [0 0 0];
				end
	

				pointslefteye = landmarkpoints(landLeftEye,leftEyeCont,LeftEye,landconf);
				pointsrighteye = landmarkpoints(landRightEye,rightEyeCont,RightEye,landconf);
				pointsmouth = landmarkpoints(landMouth,MouthCont,Mouth,landconf);
				pointslefteyebrow = landmarkpoints(landLeftEyebrow,leftEyebrowCont,LeftEyebrow,landconfEyebrow);
				pointsrighteyebrow = landmarkpoints(landRightEyebrow,RightEyebrowCont,RightEyebrow,landconfEyebrow);

				lands = [pointslefteye;pointsrighteye;pointsmouth;pointslefteyebrow;pointsrighteyebrow];
	
				xc = (max(lands(:,1)) - min(lands(:,1)))/2 + min(lands(:,1));
				yc = (max(lands(:,2)) - min(lands(:,2)))/2 + min(lands(:,2));

				h = max(lands(:,2)) - min(lands(:,2)) + 8;
				w = max(lands(:,1)) - min(lands(:,1)) + 8;

				s = [h w];
				l = max(s);

				xp = xc - l/2;
				yp = yc - l/2;

				imgFace = imcrop(A, [xp yp l l]);
				imgFace = imresize(A, [100 100]);
				Faces.flag = Faces.flag + 1;
				Faces.data{iframe} = imgFace;

			end
			end
			end
			end
			end
		end
		end
		end
		end
		end
		end
    end
end
	