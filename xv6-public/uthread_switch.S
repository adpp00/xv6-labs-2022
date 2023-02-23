	.text

/* Switch from current_thread to next_thread. Make next_thread
 * the current_thread, and set next_thread to 0.
 * Use eax as a temporary register, which should be caller saved.
 */
	.globl thread_switch
thread_switch:
	/* YOUR CODE HERE */

	pushal 

	/*save sp in *current_thread*/
	movl current_thread, %eax
	movl %esp, (%eax) 

	/*load next thread sp*/
	movl next_thread, %eax 
	movl (%eax), %esp

	popal /*pop %edi %esi %ebx %ebp %eip*/

	/*switch next_thread to current_thread*/
	movl next_thread, %eax
	movl %eax, current_thread	
	movl $0, next_thread	

	ret				/* pop return address from stack */