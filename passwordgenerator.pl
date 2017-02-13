#!/usr/bin/perl

use CGI;

my $cgi = new CGI;
print $cgi->header('text/html');

if (defined $cgi->param('ok')) 
{
	my %params = $cgi->Vars;
	my $passwordlength = ${params{password}};
 	my $numberofpassword = ${params{numberofpassword}};

	if ($passwordlength eq '') 
	{
		$passwordlength = 8;
	}
	else
	{
	}

	if ($passwordlength < 8)
	{
		print <<ENDHTML;
		<HTML>
		<HEAD>
		<TITLE>Error!</TITLE>
		</HEAD>
		<BODY>
		The password length you entered does not meet the minimum requirement. The minimum required length is 8.
		<BR>
		<BR>
		<FORM METHOD="LINK" ACTION="passwordgenerator.pl">
		<INPUT TYPE="submit" VALUE="Go Back!">
		</FORM></BODY>
		</HTML>
		ENDHTML
		}
	elsif ($numberofpassword eq '')
	{
		print <<ENDHTML;
		<HTML>
		<HEAD>
		<TITLE>Error!</TITLE>
		</HEAD>
		<BODY>
		You must print atleast 1 password.
		<BR>
		<BR>
		<FORM METHOD="LINK" ACTION="passwordgenerator.pl">
		<INPUT TYPE="submit" VALUE="Go Back!">
		</FORM></BODY>
		</HTML>
		ENDHTML
	}
	else
	{
		print "Below are the passwords you requested:";
		print "<BR>";
		print "<BR>";
		print "<BR>";
		while ($numberofpassword > 0)
		{
			&passwordmaker;
			print "<BR>";
			$numberofpassword--;
		}
		print <<ENDHTML;
		
		<BR>
		<FORM METHOD="LINK" ACTION="passwordgenerator.pl">
		<INPUT TYPE="submit" VALUE="Go Back!">
		</FORM>
		<BR>
		ENDHTML


		sub passwordmaker
		{
		 	my $numbercount = 0;
		 	my $lowercount = 0;
		 	my $uppercount = 0;
		 	my $specialcount = 0;
		 	my $firstletter = 0;
		 	my @chars = ('a'..'z','0'..'9','!','@','','$','%','^','&','*','-','_','A'..'Z');
		 	my $password = '';
		 	$password .= $chars[ rand @chars] for 1..$passwordlength;
		 	if ($password=~ m/^[a-zA-Z]/g)
		 	{
		 		$firstletter = 1;
		 	}
		 	else 
		 	{
		 		$firstletter = 0;
		 	}
		 	while($password=~/\d/g)
		 	{
		 		$numbercount=$numbercount+1;
		 	}
		 	while($password=~/[a-z]/g)
		 	{
		 		$lowercount=$lowercount+1;
		 	}
		 	while($password=~/[A-Z]/g)
		 	{
		 		$uppercount=$uppercount+1;
		 	}
		 	while($password=~ /\W/g)
		 	{
		 		$specialcount=$specialcount+1;
		 	}
		 	if( $numbercount ge 1 && $lowercount ge 1 && $uppercount ge 1 && $specialcount ge 1 && $firstletter eq 1)
		 	{
		 		print $password;
		 	}
		 	else 
		 	{
		 		$numbercount = 0;
		 		$lowercount = 0;
		 		$uppercount = 0;
		 		$specialcount = 0;
		 		$firstletter = 0;
		 		&passwordmaker;
		 	}
		}
	}
} 

else 
{
	print <<ENDHTML;
	<HTML>
	<HEAD>
	<TITLE>Password Generator</TITLE>
	</HEAD>
	<BODY>
	<FORM METHOD=POST ACTION="passwordgenerator.pl">
	Generate <INPUT TYPE=TEXT NAME="numberofpassword"> passwords.<BR>
	Each password should be <INPUT TYPE=TEXT NAME="password"> characters long. The default length is 8.<BR>
	<BR>
	<INPUT TYPE=SUBMIT NAME="ok" VALUE="Generate the Password(s)!">
	</FORM>
	</BODY>
	</HTML>
	ENDHTML
}