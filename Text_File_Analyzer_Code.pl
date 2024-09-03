#!/usr/bin/perl
use strict;
use warnings;
sub analyze_text {
  my ($file_name) = @_;
  unless (-e $file_name) {
  die "File '$file_name' does not exist.\n";
  }
  open my $fh, '<', $file_name or die "Could not open '$file_name' for reading: $!\n";
  my %word_count;
  my $char_count = 0;
  my $line_count = 0;
  my $word_total = 0; # Add word count variable my @lines;
  while (my $line = <$fh>) {
  $line_count++;
  $char_count += length($line);
  my @words = split(/\s+/, $line);
  $word_total += scalar @words; # Increment word
  count
  foreach my $word (@words) {
  $word_count{$word}++; }
  push @lines, $line; }
  close $fh;
  return (\%word_count, $char_count, $line_count, $word_total, \@lines); # Include word_total in the return 
}

sub search_and_replace {
  my ($file_name, $search, $replace) = @_;
  my ($word_count, $char_count, $line_count, $word_total, $lines_ref) = analyze_text($file_name);
  my @lines = @$lines_ref;
  my $original_file_name = $file_name . '.original'; my $modified_file_name = $file_name . '.modified';
  open my $original_fh, '>', $original_file_name or die "Could not create '$original_file_name' for writing: $!\n"; open my $modified_fh, '>', $modified_file_name or die
  "Could not create '$modified_file_name' for writing: $!\n";
  foreach my $line (@lines) {
    my $modified_line = $line;
    $line =~ s/$search/$replace/g; # Perform global search
    and replace
    print $original_fh $line;
    print $modified_fh $modified_line;
  }
  close $original_fh; close $modified_fh;
  my $original_contents = do { local $/;
  open my $fh, '<', $original_file_name; <$fh>;
  };
  my $modified_contents = do { local $/;
  open my $fh, '<', $modified_file_name; <$fh>;
  };
  return ($original_contents, $modified_contents);
}
sub extract_keywords {
  my ($file_name, $num_keywords) = @_;
  my ($word_count) = analyze_text($file_name);
  my @keywords = sort { $word_count->{$b} <=> $word_count->{$a} } keys %$word_count;

  return @keywords[0..$num_keywords - 1];
  
}

sub analyze_and_export_to_text{
  my ($file_name, $search, $replace) = @_;
  # Export results to a text file my $text_file_name =
  export_results_to_text_file($file_name,$search, $replace); print "Analysis results exported to '$text_file_name'\n";
}

sub export_results_to_text_file {
  my ($file_name, $search, $replace) = @_; my $text_file_name = 'analysis_results.txt';
  my ($word_count, $char_count, $line_count, $word_total, $lines_ref) = analyze_text($file_name);
  my ($modified_contents, $original_contents) = search_and_replace($file_name, $search, $replace);
  my $num_keywords = 5;
  my @keys = extract_keywords($file_name, $num_keywords);
  my $keywords = \@keys;
  open my $fh, '>', $text_file_name or die "Could not create $text_file_name: $!\n";
  print $fh "File Name: $file_name\n";
  print $fh "Character Count: $char_count\n"; print $fh "Word Total: $word_total\n";
  print $fh "Line Count: $line_count\n\n";
  print $fh "Top $num_keywords Keywords of $file_name are as follows :" . join(', ', @$keywords) . "\n";
  print $fh "\nOriginal Contents:\n"; print $fh $original_contents;
  print $fh "\nModified Contents:\n"; print $fh $modified_contents;
  close $fh;
  return $text_file_name;
}

sub main {
  print("Enter File Name :"); my $file_name = <STDIN>; chomp($file_name);
  my ($word_count, $char_count, $line_count, $word_total, $lines_ref) = analyze_text($file_name);
  
  print "Character Count of Original File : $char_count\n"; print "Line Count of Original File: $line_count\n";
  print "Word Count of Original File: $word_total\n";
  #Display word count
  my $num_keywords = 5;
  my @keys = extract_keywords($file_name, $num_keywords);
  my $keywords = \@keys;
  print "Top $num_keywords Keywords of $file_name are as follows :" . join(', ', @$keywords) . "\n";
  open my $fh1, '<', $file_name or die "Could not open '$file_name' for reading: $!\n";
  print("Enter the word you want to search:"); my $search = <STDIN>;
  chomp($search);
  print("Enter the substitute:"); my $replace = <STDIN>; chomp($replace);
  my ($modified_contents, $original_contents) = search_and_replace($file_name, $search, $replace);
  print "\n\n\n";
  # Display the original file contents print "Original Contents:\n\n"; print $original_contents;
  print "\n\n\n";
  # Display the modified file contents print "Modified Contents:\n\n"; print $modified_contents;
  print "\n";
  analyze_and_export_to_text($file_name, $search, $replace);
}
main();