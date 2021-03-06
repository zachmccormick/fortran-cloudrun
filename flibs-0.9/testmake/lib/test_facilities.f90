! DOC
!
!  test_facilities.f90 - Module that provides all facilities for the
!                        test programs generated with "testmake"
!
!  Copyright (C) 2000 Arjen Markus
!
!  Arjen Markus
!
!
!  General information:
!  This module contains routines and functions that are used by the
!  test programs generated by "testmake".
!
! ENDDOC
!
!  $Author$
!  $Date$
!  $Source$
!
! --------------------------------------------------------------------
!   Module:   TEST_FACILITIES
!   Author:   Arjen Markus
!   Purpose:  Provide standard test facilities
!   Context:  Used by generated test programs
! --------------------------------------------------------------------
!
module TEST_FACILITIES

   implicit none

   integer                 :: test__lun       ! LU-number for test output file
   integer                 :: test__success   ! Counts the successful tests
   logical                 :: test__input     ! Records success with input parameters
   logical                 :: test__error     ! Records if an error parameter was set
   logical                 :: test__output    ! Records success with output parameters
   logical                 :: test__failed    ! Records test failure

   interface test_equals
      module procedure test_equals_int
      module procedure test_equals_int_1d
      module procedure test_equals_int_2d
      module procedure test_equals_real
      module procedure test_equals_real_1d
      module procedure test_equals_real_2d
      module procedure test_equals_double
      module procedure test_equals_string
      module procedure test_equals_string_1d
      module procedure test_equals_logical
   end interface

contains

! --------------------------------------------------------------------
!   Function: TEST_PRINT_OPEN
!   Author:   Arjen Markus
!   Purpose:  Open the log file
!   Context:  Used at the start of the test program
!   Summary:
!             Open the file
! --------------------------------------------------------------------
!
subroutine test_print_open( filename, module )
   character(len=*), intent(in)   :: filename
   character(len=*), intent(in)   :: module

   logical                        :: opend

   do test__lun = 2,99
      inquire( test__lun, opened = opend )
      if ( .not. opend ) then
         open( test__lun, file = filename, status = 'unknown' )
         exit
      endif
   enddo

   write( test__lun, * ) 'Test program for module: ', module

   return
end subroutine test_print_open

! --------------------------------------------------------------------
!   Function: TEST_PRINT_TEXT
!   Author:   Arjen Markus
!   Purpose:  Print some text to the report file
!   Context:  Used to log text strings
!   Summary:
!             Write the text
! --------------------------------------------------------------------
!
subroutine test_print_text( string )
   character(len=*), intent(in)   :: string

   write( test__lun, * ) string

   return
end subroutine test_print_text

! --------------------------------------------------------------------
!   Function: TEST_FAILED
!   Author:   Arjen Markus
!   Purpose:  Set the failed flag if the logical value is true
!   Context:  Used in the user-supplied code
!   Summary:
!             If the first argument is true, then set the failed
!             flag to .true. and print the string
! --------------------------------------------------------------------
!
subroutine test_failed( value, string )
   logical             :: value
   character(len=*)    :: string

   if ( value ) then
      test__failed = .true.
      call test_print_text( 'Test failed: ' // trim(string) )
   endif

   return
end subroutine test_failed

! --------------------------------------------------------------------
!   Function: TEST_EQUALS
!   Author:   Arjen Markus
!   Purpose:  Return whether the two arguments are equal or not
!   Context:  Used as an automatic check
!   Summary:
!             Compare all elements of the two arguments, return
!             .true. if they are all equal, otherwise return .false.
!   Note:
!             Check that the dimensions are equal as well!
! --------------------------------------------------------------------
!
logical function test_equals_int( int1, int2 )
   integer, intent(in)     :: int1
   integer, intent(in)     :: int2

   test_equals_int = ( int1 .eq. int2 )
   return

end function test_equals_int

logical function test_equals_int_1d( int1, int2 )
   integer, intent(in), dimension(:)     :: int1
   integer, intent(in), dimension(:)     :: int2

   if ( any( shape(int1) .ne. shape(int2) ) ) then
      write( test__lun, * ) 'Unequal shapes!'
      test_equals_int_1d = .false.
   else
      test_equals_int_1d = all( int1 .eq. int2 )
   endif
   return

end function test_equals_int_1d

logical function test_equals_int_2d( int1, int2 )
   integer, intent(in), dimension(:,:)   :: int1
   integer, intent(in), dimension(:,:)   :: int2

   if ( any( shape(int1) .ne. shape(int2) ) ) then
      write( test__lun, * ) 'Unequal shapes!'
      test_equals_int_2d = .false.
   else
      test_equals_int_2d = all( int1 .eq. int2 )
   endif
   return

end function test_equals_int_2d

logical function test_equals_real( real1, real2 )
   real, intent(in)     :: real1
   real, intent(in)     :: real2

   test_equals_real = ( real1 .eq. real2 )
   return

end function test_equals_real

logical function test_equals_real_1d( real1, real2 )
   real, intent(in), dimension(:)     :: real1
   real, intent(in), dimension(:)     :: real2

   if ( any( shape(real1) .ne. shape(real2) ) ) then
      write( test__lun, * ) 'Unequal shapes!'
      test_equals_real_1d = .false.
   else
      test_equals_real_1d = all( real1 .eq. real2 )
   endif
   return

end function test_equals_real_1d

logical function test_equals_real_2d( real1, real2 )
   real, intent(in), dimension(:,:)   :: real1
   real, intent(in), dimension(:,:)   :: real2

   if ( any( shape(real1) .ne. shape(real2) ) ) then
      write( test__lun, * ) 'Unequal shapes!'
      test_equals_real_2d = .false.
   else
      test_equals_real_2d = all( real1 .eq. real2 )
   endif
   return

end function test_equals_real_2d

logical function test_equals_double( double1, double2 )
   double precision, intent(in)     :: double1
   double precision, intent(in)     :: double2

   test_equals_double = ( double1 .eq. double2 )
   return

end function test_equals_double

logical function test_equals_string( string1, string2 )
   character(len=*), intent(in)     :: string1
   character(len=*), intent(in)     :: string2

   test_equals_string = ( string1 .eq. string2 )
   return

end function test_equals_string

logical function test_equals_string_1d( string1, string2 )
   character(len=*), intent(in), dimension(:)     :: string1
   character(len=*), intent(in), dimension(:)     :: string2

   if ( any( shape(string1) .ne. shape(string2) ) ) then
      write( test__lun, * ) 'Unequal shapes!'
      test_equals_string_1d = .false.
   else
      test_equals_string_1d = all( string1 .eq. string2 )
   endif
   return

end function test_equals_string_1d

logical function test_equals_logical( log1, log2 )
   logical, intent(in)  :: log1
   logical, intent(in)  :: log2

   test_equals_logical = log1 .eqv. log2
   return

end function test_equals_logical

end module test_facilities
