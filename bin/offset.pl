#!/usr/bin/perl
#
# This program will allow you to calculate the offset inside the binary for patching purposes
# (c) 2009 Fractal Guru - reverse\@put.as - http://reverse.put.as
#
# Feel free to do whatever you want with this code (keep the credits!) 
#
# * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS "AS IS"
# * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
# * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# * POSSIBILITY OF SUCH DAMAGE.
#
my $VERSION = "1.21";
# change me to 1 to have debug messages
my $debug = 0;

my %table;
my $buffer = "";

my $info = <<INFO;
Mach-o Binary Offset Calculator v$VERSION
.....................................
(c) 2009 fG! - http://reverse.put.as - reverse\@put.as

Usage: $0 <file> <offset> [ppc]

Where:
<file>   = File to calculate offset from
<offset> = Offset from otx/otool (in hexadecimal format!)
[ppc]    = To calculate offset for PPC architecture (default is i386)

Example for i386:
$0 /bin/ls 23f0

Example for PPC:
$0 /bin/ls 16a4 ppc

INFO

my $header = <<HEADER;
Mach-o Binary Offset Calculator v$VERSION
.....................................
(c) 2009 fG! - http://reverse.put.as - reverse\@put.as

HEADER

sub help
{
	print $info;
	exit 1;
}

if (!defined($ARGV[0]))
{
	help();
}

my $filetoopen = $ARGV[0];
if (! -e $filetoopen)
{
	print $header;
	print "ERROR: Can't access file $filetoopen !\n";
	exit(1);
}

if (!defined($ARGV[1]))
{
	print $header;
	print "ERROR: No offset ! Please specify one !\n";
	exit(1);
}
my $myoffset = hex($ARGV[1]);

# architecture to calculate offset for
my $target = "i386";
$target = "ppc" if (lc($ARGV[2]) eq "ppc") ;

print $header;

# create filehandle
open(FILE,"<$filetoopen");
#struct fat_header 
#{ 
#    uint32_t magic; 
#    uint32_t nfat_arch; 
#}; 
# Total Size: 8 bytes
sysseek(FILE,0,0);
sysread(FILE, $buffer, 8);
# this is always big-endian
my ($magicheader, $nfat_arch) = unpack("NN", $buffer);
printf("Magic Header: 0x%x\n", $magicheader) if $debug;
# if it's a fat binary we need to find where the i386 binary is
if ($magicheader == 0xcafebabe)
{
	# it's rather safe (but still incorrect) to assume there is a i386 and PPC binary inside the fat binary.
	# still incorrect because it could have a x86 and x86_64 and no PPC... I can live with it for now ;)
	printf("Found a Mach-O fat binary with %d architectures!\n", $nfat_arch);
	print "Finding i386 and PPC base address...\n";
	#struct fat_arch 
	#{ 
    #	cpu_type_t cputype; 
    #	cpu_subtype_t cpusubtype; 
    #	uint32_t offset; 
    #	uint32_t size; 
    #	uint32_t align; 
	#}; 
	# Total Size: 20 bytes
	$initialposition = sysseek(FILE, 0, 1);
	# read info from all available binaries inside
	for ($i=0; $i < $nfat_arch; $i++)
	{
		sysread(FILE, $buffer, 20);
		($fatinfo[$i]->{'cputype'}, $fatinfo[$i]->{'cpusubtype'}, $fatinfo[$i]->{'offset'}, $fatinfo[$i]->{'size'}, $fatinfo[$i]->{'align'}) = unpack("NNNNN", $buffer);
		if ($fatinfo[$i]->{'cputype'} == 7) { $intelbaseaddress = $fatinfo[$i]->{'offset'}; };
		if ($fatinfo[$i]->{'cputype'} == 18) { $ppcbaseaddress = $fatinfo[$i]->{'offset'}; };
	}
	printf("Intel base address: 0x%x\n", $intelbaseaddress) if $debug;
	printf("PPC base address: 0x%x\n", $ppcbaseaddress) if $debug;
	$targetbaseaddress = $intelbaseaddress if ($target eq "i386");
	$targetbaseaddress = $ppcbaseaddress if ($target eq "ppc");
# if it's a i386 only binary then base address is 0
}
elsif ($magicheader == 0xcefaedfe)
{
	print "Found a Mach-O i386 only binary!\n";
	$targetbaseaddress = 0x0;
	$target = "i386";
}
elsif ($magicheader == 0xfeedface)
{
	print "Found a Mach-O PPC only binary!\n";
	$targetbaseaddress = 0x0;
	$target = "ppc";
}

# /usr/include/mach-o/loader.h
#struct mach_header 
#{ 
#    uint32_t magic; 
#    cpu_type_t cputype; 
#    cpu_subtype_t cpusubtype; 
#    uint32_t filetype; 
#    uint32_t ncmds; 
#    uint32_t sizeofcmds; 
#    uint32_t flags; 
#}; 
# Total Size: 28 bytes
print "Reading Mach Header...\n";
sysseek(FILE, $targetbaseaddress, 0);
sysread(FILE, $buffer, 28);
# use L in unpack because it's exactly 32bits long (that's what we want!)
# PPC is big-endian so unpack template must be different! very important ;)
($magic, $cputype, $cpusubtype, $filetype, $ncmds, $sizeofcmds, $flags) = unpack("LLLLLLL", $buffer) if ($target eq "i386");
($magic, $cputype, $cpusubtype, $filetype, $ncmds, $sizeofcmds, $flags) = unpack("NNNNNNN", $buffer) if ($target eq "ppc");
print("\nDebug Information\n-----------------\n") if $debug;
printf("Magic number: %x\n", $magic) if $debug;
printf("Cpu type: %d, subtype is: %d\n", $cputype, $cpusubtype) if $debug;
printf("Filetype: %x\n", $filetype) if $debug;
printf("Number of commands: %d\n", $ncmds) if $debug;
printf("Size of commands: 0x%x\n", $sizeofcmds) if $debug;
printf("Flags: %x\n", $flags) if $debug;
printf("Target architecture: %s\n", $target) if $debug;

#struct load_command 
#{
#    uint32_t cmd; 
#    uint32_t cmdsize; 
#}; 
# Total size: 8 bytes
# process all load commands
  for ($i=0; $i < $ncmds; $i++)
  {
  	# read each load_command where we get cmd number and total size for it
  	$initialposition = sysseek(FILE, 0, 1);
  	sysread(FILE, $buffer, 8);
  	($cmd, $cmdsize) = unpack("LL", $buffer) if ($target eq "i386");
  	($cmd, $cmdsize) = unpack("NN", $buffer) if ($target eq "ppc");
    $table[$i]->{'position'} = $initialposition;
	$table[$i]->{'cmd'} = $cmd;
	$table[$i]->{'cmdsize'} = $cmdsize;	
	# move to the next load command. we can find it by adding the previous load command size minus 8 (because we have read 8 bytes from the previous load command)
	$seekposition = sysseek(FILE, $initialposition+$cmdsize, 0);
  }

  # now let's find our __text,__TEXT section inside a load command
  foreach (@table)
  {
  	if ($_->{'cmd'} == 1)
  	{
  		print("Searching for __text,__TEXT section at position: $_->{'position'}\n") if $debug;
  		# we know it's a LC_SEGMENT so we must read it and see if we can find out __TEXT segment and __text,__TEXT section
  		# skip cmd and cmdsize since we already have them
  		sysseek(FILE, $_->{'position'}+8, 0);
		#struct segment_command 
		#{ 
    	#	uint32_t cmd; 
    	#	uint32_t cmdsize; 
    	#	char segname[16]; 
		#   uint32_t vmaddr; 
		#   uint32_t vmsize; 
		#   uint32_t fileoff; 
		#   uint32_t filesize; 
		#   vm_prot_t maxprot; 
		#   vm_prot_t initprot; 
		#   uint32_t nsects; 
		#   uint32_t flags; 
		#}; 
		# Total Size: 48 bytes
  		sysread(FILE, $buffer, 48);
  		($segname, $vmaddr, $vmsize, $fileoff, $filesize, $maxprot, $initprot, $nsects, $flags) = unpack("Z16NNNNNNLN", $buffer) if ($target eq "i386");
  		($segname, $vmaddr, $vmsize, $fileoff, $filesize, $maxprot, $initprot, $nsects, $flags) = unpack("Z16NNNNNNNN", $buffer) if ($target eq "ppc");
  		printf("Segment Name: %s Number of sections: %i \n", $segname, $nsects) if $debug;
  		$currentposition = sysseek(FILE, 0,1);
  		# we are interested in further reading if the number of sections is more than 1.
  		if ($nsects > 0)
  		{
  			for ($x=0; $x < $nsects; $x++)
  			{
	  			#struct section 
				#{ 
    			#	char sectname[16]; 
    			#	char segname[16]; 
				#   uint32_t addr; 
				#   uint32_t size; 
				#   uint32_t offset; 
				#   uint32_t align; 
				#   uint32_t reloff; 
				#   uint32_t nreloc; 
				#   uint32_t flags; 
				#   uint32_t reserved1; 
				#   uint32_t reserved2; 
				#}; 
			    # Total size: 16 + 16 + 9*4 = 68 bytes
			    # read sectname, segname, addr, size, offset
		    	sysread(FILE, $buffer, 68);
		    	($sectname, $segname, $addr, $size, $offset) = unpack("Z16Z16VVV", $buffer) if ($target eq "i386");
		    	($sectname, $segname, $addr, $size, $offset) = unpack("Z16Z16NNN", $buffer) if ($target eq "ppc");
		    	printf("Sectname: %s Segname: %s Offset: %x\n", $sectname, $segname, $offset) if $debug;
		    	# store the information we need to calculate the correct offset
		    	$goodoffset = $offset if ($sectname eq "__text" && $segname eq "__TEXT");
		    	$goodvmaddr = $addr if ($sectname eq "__text" && $segname eq "__TEXT");
		    	$goodsize = $size if ($sectname eq "__text" && $segname eq "__TEXT");    	
  			}
  		}
  		print "\n" if $debug;
  	}
  }
   
printf("CPU base address: 0x%x Goodoffset: 0x%x MyOffset: 0x%x Goodvmaddr: 0x%x\n", $intelbaseaddress, $goodoffset, $myoffset, $goodvmaddr) if $debug;
# check if input offset is valid - must be inside the __text segment
if ($myoffset < $goodvmaddr || $myoffset > $goodvmaddr+$goodsize)
{
	print "\nERROR: Your offset is outside code region\n";
	exit(1);
}
# calculate the offset we want
$patchedoffset = $targetbaseaddress + $goodoffset + $myoffset - $goodvmaddr;
# and print it !
printf("\nReal offset to be patched: 0x%x\n", $patchedoffset);
# end of story!
close(FILE);
