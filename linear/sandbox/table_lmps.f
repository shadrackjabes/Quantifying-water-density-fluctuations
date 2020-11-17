         program table
         implicit none
         integer nmax,nlines
         double precision delr
c        parameters tested to give consistent table potential in lammps
         parameter (delr=0.000035,nmax=1e6,nlines=1000000)
         integer j
         double precision rr,u(nmax),f(nmax),rj

         open(unit=10,file='neg_dU_dr.xxxx.txt')
         open(unit=20,file='table.xxxx')
         open(unit=30,file='r.U.xxxx.txt')

         do j=1,nlines
         read(30,*)rr,u(j)
         enddo

         write(20,*)''
         write(20,*)'SOLUTE_WATER'
         write(20,33)'N',nlines,'R',delr*1,delr*nlines
         write(20,*)
         do j = 1,nlines
         rj=delr*j
         read(10,*)rr,f(j)
         write(20,34)j,rj,u(j),f(j)
         enddo
33       format(a3,i16,a3,2f25.20)
34       format(i16,3f25.20)
         stop
         end
