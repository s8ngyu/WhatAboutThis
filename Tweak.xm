%hook PSUIAboutController
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return %orig + 5;
	}
	return %orig;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

	static NSString *CellIdentifier = @"WhatAboutThis";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (indexPath.section == 0) {
		if(indexPath.row == 1) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
			cell.textLabel.text = @"Hide me";
			cell.detailTextLabel.text = @"I'm a spy from the Apple";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.hidden = TRUE;
			return cell;
        }
		if(indexPath.row == 2) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
			cell.textLabel.text = @"Software Version";
			cell.detailTextLabel.text = [[UIDevice currentDevice] systemVersion];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
        }
		if(indexPath.row == 3) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
			cell.textLabel.text = @"Model Name";
			cell.detailTextLabel.text = @"N/A";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
        }
		if(indexPath.row == 4) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
			cell.textLabel.text = @"Model Number";
			cell.detailTextLabel.text = @"N/A";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
        }
		if(indexPath.row == 5) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
			cell.textLabel.text = @"Serial Number";
			cell.detailTextLabel.text = @"N/A";
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			return cell;
        }
    }
	return %orig;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 & indexPath.row == 1) {
		return 0;
	}
    return %orig;
}
%end