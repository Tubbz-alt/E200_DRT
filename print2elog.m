function print2elog(handles,figin,plotfcn,comment,camname,data)
	fig=figure();
	ax=axes();
	plotfcn(handles);
	
	xlim_main=get(figin,'XLim');
	ylim_main=get(figin,'YLim');
	set(ax,'XLim',xlim_main);
	set(ax,'YLim',ylim_main);
	
	prompt    = {'Title','X Label','Y Label','Elog Title','Comment to Print'};
	dlg_title = 'Plot Details';
	num_lines = [1,30;1,20;1,20;1,30;10,50];
	
	% [temp,camname] = get_imgstruct(handles);
	% comment        = get(handles.Comment,'String');
	comment = flattenstringrows(comment);
	dataset        = data.raw.metadata.param.dat{1}.save_name;
	comment2print  = sprintf(['Dataset: ' dataset '\n' comment]);
	def            = {camname,'','',['DRT Data from ' camname],comment2print};
	
	result=inputdlg(prompt,dlg_title,num_lines,def);
	comment2print = flattenstringrows(result{5})
	% comment2print = cellstr(result{5});
	% temp = ''
	% for i=1:numel(comment2print)-1
	%         temp = [temp comment2print{i} '\n'];
	% end
	% temp = [temp comment2print{end}];
	% comment2print=temp;
	
	addlabels(result{2},result{3},result{1});
	
	printans=questdlg(sprintf(['Comment: \n\n' comment2print '\n\nPrint to Elog?']),'Final Confirmation','Yes','No','No');
	if strcmp(printans,'Yes')
		authstr=data.raw.metadata.param.dat{1}.experiment;
		util_printLog(fig,'title',result{4},'text',sprintf(comment2print),'author',authstr);
	end
end
