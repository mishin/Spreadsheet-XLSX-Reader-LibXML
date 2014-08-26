#########1 Test File for Spreadsheet::XLSX::Reader::Error   6#########7#########8#########9
#!perl
$| = 1;

use	Test::Most;
use	Test::Moose;
use Capture::Tiny qw( capture_stderr );
use	lib 
		'../../../../../Log-Shiras/lib',
		'../../../../lib',;
#~ use Log::Shiras::Switchboard v0.21 qw( :debug );#
###LogSD	my	$operator = Log::Shiras::Switchboard->get_operator(#
###LogSD						name_space_bounds =>{
###LogSD							UNBLOCK =>{
###LogSD								log_file => 'trace',
###LogSD							},
###LogSD							Test =>{
###LogSD								UNBLOCK =>{
###LogSD									log_file => 'trace',
###LogSD								},
###LogSD							},
###LogSD						},
###LogSD						reports =>{
###LogSD							log_file =>[ Print::Log->new ],
###LogSD						},
###LogSD					);
###LogSD		$operator->add_skip_up_caller( qw( Carp __ANON__ ) );
###LogSD	use Log::Shiras::Telephone;
###LogSD	use Log::Shiras::UnhideDebug;
use Spreadsheet::XLSX::Reader::Error v0.1;
my  ( 
			$test_instance, $capture,
	);
my 			@class_attributes = qw(
				error_string
				should_warn
			);
my  		@class_methods = qw(
				new
				clear_error
				error
				set_error
				set_warnings
				if_warn
			);
my			$answer_ref = [
			];
###LogSD	my	$phone = Log::Shiras::Telephone->new( name_space => 'main', );
###LogSD		$phone->talk( level => 'info', message => [ "easy questions ..." ] );
map{ 
has_attribute_ok
			'Spreadsheet::XLSX::Reader::Error', $_,
										"Check that Spreadsheet::XLSX::Error has the -$_- attribute"
} 			@class_attributes;
map{
can_ok		'Spreadsheet::XLSX::Reader::Error', $_,
} 			@class_methods;

###LogSD		$phone->talk( level => 'info', message => [ "harder questions ..." ] );
lives_ok{
			$test_instance =	Spreadsheet::XLSX::Reader::Error->new(
									#~ should_warn	=> 0,# to turn off cluck
								);
}										"Prep a new Error instance";

###LogSD		$phone->talk( level => 'info', message => [ "hardest questions ..." ] );
			$capture = capture_stderr{
is			$test_instance->set_error( "Watch out World" ), 1,
										"Send an error message";
			};
like		$capture, qr/, '(Watch out World|CODE\(0x.{6}\))'\) called at (\.(\/t)?\/Spreadsheet\/XLSX\/Reader\/)?02_error\.t line \d{2}/,
										"...and check for the correct clucked warning message";
is			$test_instance->error, "Watch out World",
										"Make sure that the warning as stated is still available";
explain 								"...Test Done";
done_testing();

###LogSD	package Print::Log;
###LogSD	use Data::Dumper;
###LogSD	sub new{
###LogSD		bless {}, shift;
###LogSD	}
###LogSD	sub add_line{
###LogSD		shift;
###LogSD		my @input = ( ref $_[0]->{message} eq 'ARRAY' ) ? 
###LogSD						@{$_[0]->{message}} : $_[0]->{message};
###LogSD		my ( @print_list, @initial_list );
###LogSD		no warnings 'uninitialized';
###LogSD		for my $value ( @input ){
###LogSD			push @initial_list, (( ref $value ) ? Dumper( $value ) : $value );
###LogSD		}
###LogSD		for my $line ( @initial_list ){
###LogSD			$line =~ s/\n/\n\t\t/g;
###LogSD			push @print_list, $line;
###LogSD		}
###LogSD		printf( "name_space - %-50s | level - %-6s |\nfile_name  - %-50s | line  - %04d   |\n\t:(\t%s ):\n", 
###LogSD					$_[0]->{name_space}, $_[0]->{level},
###LogSD					$_[0]->{filename}, $_[0]->{line},
###LogSD					join( "\n\t\t", @print_list ) 	);
###LogSD		use warnings 'uninitialized';
###LogSD	}

###LogSD	1;