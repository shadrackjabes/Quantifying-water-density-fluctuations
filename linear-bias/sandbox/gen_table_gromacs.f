      program gen_table
      implicit none
      integer nmax
      parameter (nmax=1e7)
      double precision boxl,prec
      integer nbins,j,sampleno
      double precision r,uofr(nmax),neg_du_dr(nmax)
      
      open(unit=10,file='neg_dU_dr.txt')
      open(unit=21,file='table_P_P.xvg')
      open(unit=20,file='table_P_OW.xvg')
      open(unit=30,file='r.U.txt')

      boxl=5.5
      prec=0.0005
      sampleno=int(boxl/prec) 

      do j=1,sampleno
         read(30,*)r,uofr(j)
      enddo

      do j=1,sampleno
         read(10,*)r,neg_du_dr(j) 
          r=prec*(j-1)
c          write(6,'(7f14.10)')r, 1/r, 1/(r*r)
c     x         ,-1/(r**6),-6/(r**7), 1/(r**9)
c     x         ,9/(r**10)
          write(20,'(1f16.4,6e24.10)')r,0.0,0.0,0.0,0.0
     x    ,uofr(j),neg_du_dr(j)
          write(21,'(1f16.4,6e24.10)')r,0.0,0.0,0.0,0.0
     x    ,0.0,0.0
      enddo

      stop
      end
