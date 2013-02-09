% a little 16pt hskip for a line
\def\midline#1{\line{\hskip16pt\relax#1\hfil}}

@ This is the first PSP assignment --- {\tt ``Mean and Deviation''}.

Write a program to calculate the mean and standard deviation of a series of {\tt n} real numbers using a linked list. The mean is the average of the numbers. The formula for standard deviation is

$delta (x_1... x_n) = sqrt(sum(x_1 - x_avg)*(x_l-x_avg) /(n-1)  $

\bigskip Here code starts:

@c
@<includes@>@/
@<types@>@/
@<routines@>@/
@<tests@>@/

@ @<incl...@>+=
#include <stdio.h>


@ I use google gtest for TDD.
@<incl...@>+=
#include <gtest/gtest.h>

@ @<type...@>+=
typedef struct num_elem_st {
    float v;
    struct num_elem_st* next;
}num_elem_t;

@ test suite.
@<types@>+=
class ex_test : public testing::Test
{
public: 
    void SetUp();
    num_elem_t a_0;
    num_elem_t a_1;
    num_elem_t a_2;
    num_elem_t a_3;
    num_elem_t a_4;
    num_elem_t a_5;
    num_elem_t a_6;
    num_elem_t a_7;
    num_elem_t a_8;
};


@ First Test case.
@<tests...@>+=
TEST_F(ex_test, test_of_mean)
{
    float ave = calc_average_of_elements(&a_0);
    ASSERT_FLOAT_EQ(10.222222, ave);    
}
@ Build the test example data.
@<rout...@>+=
void ex_test::SetUp() 
{
    a_0.v = 4; a_0.next = &a_1;
    a_1.v = 9; a_1.next = &a_2;
    a_2.v = 11; a_2.next = &a_3;
    a_3.v = 12; a_3.next = &a_4;
    a_4.v = 17; a_4.next = &a_5;
    a_5.v = 5; a_5.next = &a_6;
    a_6.v = 8; a_6.next = &a_7;
    a_7.v = 12; a_7.next = &a_8;
    a_8.v = 14; a_8.next = NULL;
}
 

@ 
@<rout...@>+=
float calc_average_of_elements(num_elem_t* node)
{
    
    float sum = 0;
    int r;
    num_elem_t* p; 
    if(node == NULL) return 0;
    for(r=0, p=node;p!=NULL; p=p->next, r++) {
        sum+=p->v;
    }
    return sum/r;
}

@ Test ofstandard deviation 
@<test...@>+=
TEST_F(ex_test, test_of_std_dev)
{
    float ave = calc_stddev_of_elements(&a_0);
    ASSERT_FLOAT_EQ(3.9377875, ave);    
}

@ @<rout...@>+=
int calc_number_of_elements(num_elem_t* node)
{
    int r;
    num_elem_t* p; 
    for(r=0, p=node;p!=NULL; p=p->next, r++);
    return r;
}

float calc_stddev_of_elements(num_elem_t* node)
{
    float mean; 
    float sum = 0;
    int r;
    int nums;
    num_elem_t* p; 
    if(node == NULL) return 0;
    for(r=0, p=node;p!=NULL; p=p->next, r++) {
        sum+=p->v;
    }
    mean = sum/r;
    nums = calc_number_of_elements(node);
    double dsum = 0;
    for(r=0, p=node;p!=NULL; p=p->next, r++) {
#ifdef DEBUG_DUMP
        printf("### %d %.2f\n", r, pow(p->v - mean, 2));
#endif
        dsum+= pow( p->v - mean, 2);
    }
    return sqrt(dsum/nums);
 
}

@ @<incl...@>+=
#include <math.h>

@ What means for standard deviation?  Below is an example, the two group
of numbers have the same average, but the later one are clearly spread out.

@<test...@>+=
TEST_F(ex_test, test_of_std_dev_spread_out)
{
    a_0.v = 15; a_0.next = &a_1;
    a_1.v = 15; a_1.next = &a_2;
    a_2.v = 15; a_2.next = &a_3;
    a_3.v = 14; a_3.next = &a_4;
    a_4.v = 16; a_4.next = NULL;
     float stddev = calc_stddev_of_elements(&a_0);
    ASSERT_NEAR(stddev, 0, 1);    

    a_0.v = 2; a_0.next = &a_1;
    a_1.v = 7; a_1.next = &a_2;
    a_2.v = 14; a_2.next = &a_3;
    a_3.v = 22; a_3.next = &a_4;
    a_4.v = 30; a_4.next = NULL;
     float stddev2 = calc_stddev_of_elements(&a_0);
    ASSERT_NEAR(stddev2, 10, 1);    
}

@ @<test...@>+=
TEST_F(ex_test, test_of_std_dev_no_spread)
{
    a_0.v = 1; a_0.next = &a_1;
    a_1.v = 5; a_1.next = &a_2;
    a_2.v = 2; a_2.next = &a_3;
    a_3.v = 7; a_3.next = &a_4;
    a_4.v = 3; a_4.next = &a_5;
    a_5.v = 5; a_5.next = &a_6;
    a_6.v = 3; a_6.next = NULL;
    float stddev = calc_stddev_of_elements(&a_0);

    a_0.v = 3; a_0.next = &a_1;
    a_1.v = 7; a_1.next = &a_2;
    a_2.v = 4; a_2.next = &a_3;
    a_3.v = 9; a_3.next = &a_4;
    a_4.v = 5; a_4.next = &a_5;
    a_5.v = 7; a_5.next = &a_6;
    a_6.v = 5; a_6.next = NULL;
    float stddev2 = calc_stddev_of_elements(&a_0);
    ASSERT_NEAR(stddev, stddev2, 0.01);    
#ifdef DEBUG_DUMP
    printf("### %f %f\n",stddev, stddev2);
#endif
}
@ x is 4 5 6 7 8, f is 9 14 22 11 17, apply deviation I should get 1.32
@<test...@>+=
TEST_F(ex_test, test_of_std_dev_group_data)
{
    int x[5] = { 4 ,5, 6, 7, 8};
    a_0.v = 9; a_0.next = &a_1;
    a_1.v = 14; a_1.next = &a_2;
    a_2.v = 22; a_2.next = &a_3;
    a_3.v = 11; a_3.next = &a_4;
    a_4.v = 17; a_4.next = NULL;
    float stddev = calc_stddev_of_elements_2(&a_0);
    printf("###nnd: %f \n",stddev);
}
@ @<rout...@>+=
float calc_stddev_of_elements_2(num_elem_t* node)
{
    float mean; 
    float sum = 0;
    int r;
    int nums;
    num_elem_t* p; 
    if(node == NULL) return 0;
    for(r=0, p=node;p!=NULL; p=p->next, r++) {
        sum+=p->v;
    }
    nums = calc_number_of_elements(node);
    mean = sum/nums;
    double dsum = 0;
    for(r=0, p=node;p!=NULL; p=p->next, r++) {
#ifdef DEBUG_DUMP
        printf("### %d %.2f\n", r, pow(p->v - mean, 2));
#endif
        dsum+= pow( p->v - mean, 2);
    }
    return sqrt(dsum/sum);
 
}

@ Index.
