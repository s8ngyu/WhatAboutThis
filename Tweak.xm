%hook PSUIAboutController
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return 5;
	}

	return %orig;
}
%end