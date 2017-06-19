#include "colors.inc"

camera {
    location <20, 5, -60>
    look_at <20, 0, 0>
}

light_source {
    <0, 0, -30>
    color White
} 

plane {
	<0, 1, 0>, -1
	pigment {
		checker
		color Green
		color Blue
	}
}
   
#declare baseSphere = sphere {
    <0, 0, 0> 3
    texture {
        pigment {
            color White
        }
    }
    finish {
        phong 0.9
    }    
} 

#declare baseBox = box {
    <-3, -3, -3>
    <3, 3, 3>
    texture {
        pigment {
            color White
        }
    }
    finish {
        phong 0.9
    }            
    translate <0, -1, 0>
}
   
#declare join = sphere { //Join for body and head
    <0, 0, 0> 0.8
    texture {
        pigment {
            color Gray
        }
    }
    finish {
        phong 0.9
    }    
}
     
#declare bodyCylinder = cylinder {
    <0, 0, 0>
    <0, 6, 0> 0.5
    texture {
        pigment {
            color White
        }
    }
    finish {
        phong 0.9
    }
}

#declare externalHead = cone {
	<0, 0, 0> 3
	<0, 4, 0> 0
	texture { 
		pigment {
			color White
		}
	}
	finish {
		phong 0.9
	}
}

#declare internalHead = cone {
	<0, -0.1, 0> 2.9
	<0, 4, 0> 0
	texture{
		pigment {
			color Black
		}
	}
	finish {
		phong 0.9
	}
}


#declare base = difference {
    #object{baseSphere}
    #object{baseBox}
    translate <0, -3, 0>
}  

#object{
	base
	#if (frame_number > 16 & frame_number <= 20)
		rotate<0, 0, (frame_number-16) * -10>
		translate<(frame_number-16) * 5, (frame_number-16) * 2, 0>
	#end
	#if (frame_number > 20 & frame_number <= 24)
		rotate<0, 0, (25 - frame_number) * 10>
		translate<(frame_number-16) * 5, (24 - frame_number) * 2, 0>
	#end
}

#declare bodyBase = union{
	#object{
		bodyCylinder
	}
	#object{
		join
	}
}

#declare bodyHead = union{
	#object{
		bodyCylinder
	}
	#object {
		join
	}
}

#object{
	bodyBase
	rotate<0, 0, 45>
	#if (frame_number > 8 & frame_number <= 12)
		rotate<0, 0, (frame_number - 8) * 5>
	#end
	#if (frame_number > 12 & frame_number <= 16)
		rotate<0, 0, (16 - frame_number) * 5>
	#end
	#if (frame_number > 16 & frame_number <= 20)
		rotate<0, 0, (frame_number - 16) * -5>
		translate<(frame_number-16) * 5, (frame_number-16) * 2, 0>
	#end
	#if (frame_number > 20 & frame_number <= 24)
		rotate<0, 0, (24 - frame_number) * -5>
		translate<(frame_number-16) * 5, (24 - frame_number) * 2, 0>
	#end
}

#object{
	bodyHead
	rotate<0, 0, -90>
	translate<0, 6, 0>
	rotate<0, 0, 45>
	#switch (frame_number)
	// Agachamento do bodyHead
	#case (9)
		rotate<0, 0, -5>
		translate<-0.8, -0.8, 0>
	#break
	#case (10)
		rotate<0, 0, -10>
		translate<-1.5, -1.5, 0>
	#break
	#case (11)
		rotate<0, 0, -15>
		translate<-2.3, -2.3, 0>
	#break
	#case (12)
		rotate<0, 0, -20>
		translate<-3, -3, 0>
	#break
	// Return do bodyHead
	#case(13)
		rotate<0, 0, -15>
		translate<-2.3, -2.3, 0>
	#break
	#case(14)
		rotate<0, 0, -10>
		translate<-1.5, -1.5, 0>
	#break
	#case(15)
		rotate<0, 0, -5>
		translate<-0.8, -0.8, 0>
	#break
	// Levantamento e trajeto do bodyHead
	#case (17)
		rotate<0, 0, 5>
		translate<5.5, 3, 0>
	#break
	#case (18)
		rotate<0, 0, 10>
		translate<11, 6, 0>
	#break
	#case (19)
		rotate<0, 0, 15>
		translate<17.5, 8, 0>
	#break
	#case(20)
		rotate<0, 0, 20>
		translate<23, 11, 0>
	#break
	// Descida e trajeto do bodyHead
	#case(21)
		rotate<0, 0, 15>
		translate<27.5, 8, 0>
	#break
	#case(22)
		rotate<0, 0, 10>
		translate<31, 6, 0>
	#break
	#case(23)
		rotate<0, 0, 5>
		translate<35.5, 3, 0>
	#break
	#case(24)
		rotate<0, 0, 0>
		translate<40, 0, 0>
	#break
	#end
}	

#declare head = union{
	difference {
		#object{
			externalHead
		}
		#object {
			internalHead
		}
		finish{
			phong 0.9
		}
	}
	#object{
		join
		translate<0, 4, 0>
	}
}

#if (frame_number <= 8)
	#object{
		head
		translate<0, -4, 0>
		// Apresentação Head
		#if (frame_number > 0 & frame_number <= 4)
			rotate<frame_number*22.5, 0, 0>
		#else
			// Retorno do Head
			#if (frame_number > 4 & frame_number <= 8)
				rotate<(8-frame_number)*22.5, 0, 0>
				/*
			#else
				#if (frame_number > 8)
					rotate<0, 0, ((12-frame_number)*-10)-10>
				#end
				*/
			#end
		#end
		rotate<0, 0, 45>
		translate<6, 6, 0>
		rotate<0, 0, 45> 
	}
#else
	#object {
		head
		translate<0, -4, 0>
		#switch (frame_number)
		// Inclinação da Head para agachamento
		#case (9)
			rotate<0, 0, 40>
			translate<6, 6, 0>
			rotate<0, 0, 45>
			translate<0, -0.8, 0>
		#break
		#case (10)
			rotate<0, 0, 30>
			translate<6, 6, 0>
			rotate<0, 0, 45>
			translate<0, -1.5, 0>
		#break
		#case(11)
			rotate<0, 0, 20>
			translate<6, 6, 0>
			rotate<0, 0, 45>
			translate<0, -2.5, 0>
		#break
		#case (12)
			rotate<0, 0, 10>
			translate<6, 6, 0>
			rotate<0, 0, 45>
			translate<0, -3.4, 0>
		#break
		// Return da Head para o salto
		#case(13)
			rotate<0, 0, 20>
			translate<6, 6, 0>
			rotate<0, 0, 45>
			translate<0, -2.5, 0>
		#break
		#case(14)
			rotate<0, 0, 30>
			translate<6, 6, 0>
			rotate<0, 0, 45>
			translate<0, -1.5, 0>
		#break
		#case(15)
			rotate<0, 0, 40>
			translate<6, 6, 0>
			rotate<0, 0, 45>
			translate<0, -0.8, 0>
		#break
		#case(16)
			rotate<0, 0, 45>
			translate<6, 6, 0>
			rotate<0, 0, 45>
		#break
		// Levantamento e trajeto da Head para salto
		#case (17)
			rotate<0, 0, 55>
			translate<6, 6, 0>
			rotate<0, 0, 45>
			translate<5, 3, 0>
		#break
		#case (18)
			rotate<0, 0, 75>
			translate<6, 6, 0>
			rotate<0, 0, 45>
			translate<9.8, 6, 0>
		#break
		#case (19)
			rotate<0, 0, 85>
			translate<6, 6, 0>
			rotate<0, 0, 45>
			translate<15.5, 8, 0>
		#break
		#case (20)
			rotate<0, 0, 85>
			translate<6, 6, 0>
			rotate<0, 0, 45>
			translate<20, 10, 0>
		#break
		// Descida e trajeto da Head
		#case(21)
			rotate<0, 0, 25>
			translate<6, 6, 0>
			rotate<0, 0, 45>
			translate<25.5, 8, 0>
		#break
		#case(22)
			rotate<0, 0, 15>
			translate<6, 6, 0>
			rotate<0, 0, 45>
			translate<29.5, 6, 0>
		#break
		#case(23)
			rotate<0, 0, 25>
			translate<6, 6, 0>
			rotate<0, 0, 45>
			translate<35, 3, 0>
		#break
		#case(24)
			rotate<0, 0, 45>
			translate<6, 6, 0>
			rotate<0, 0, 45>
			translate<40, 0, 0>
		#break
		#end
	}
#end