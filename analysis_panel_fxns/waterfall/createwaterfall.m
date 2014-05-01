function handles=createwaterfall(handles)
	imgstr=handles.handles_main.data.raw.images.(handles.handles_main.camname);
	numimgs=length(imgstr.UID);
	display(['Processing ' num2str(numimgs) ' into waterfall...']);
	if get(handles.rotation,'Value')
		vertical_bool = true;
		sum_dimension = 2;
		arraysize = handles.roi.maxy-handles.roi.miny+1;
	else
		vertical_bool = false;
		sum_dimension = 1;
		arraysize = handles.roi.maxx-handles.roi.minx+1;
	end

	waterarray=zeros(numimgs,arraysize);
	for i=1:numimgs
		if mod(i,10)==0
			display(['Image number ' num2str(i)]);
		end
		images=E200_load_images(imgstr,imgstr.UID(i));
		images=images{1};
		subimg=images(handles.roi.miny:handles.roi.maxy,handles.roi.minx:handles.roi.maxx);
		subimg=sum(subimg,sum_dimension);
		waterarray(i,:)=subimg;
	end
	if vertical_bool
		waterarray=rot90(waterarray,-1);
	end
	handles.waterarray = waterarray;
	maxcounts = max(max(waterarray));
	set(handles.Maxcounts,'Max',maxcounts);
	set(handles.Maxcounts,'Value',maxcounts);
	set(handles.Maxcounts,'SliderStep',[0.01,0.1])

	set(handles.Mincounts,'Max',maxcounts-1);
	set(handles.Mincounts,'Value',0);
	set(handles.Mincounts,'SliderStep',[0.01,0.1])

	% figure;
	plotoutput(handles);
	display('Finished!');
end