/*
** list.h --- list control
*/
#ifndef LIST_H_
#define LIST_H_

struct list_header {
  struct list_header *next;
  struct list_header *prev;
};

#define list_init(list)\
	{(list)->prev = (list)->next = (list);}

#define list_empty(list)\
	((list)->next == (list))

#define list_head(list)\
	((list)->next)

#define list_tail(list)\
	((list)->prev)

#define list_alloc(list, size, idx)\
	{ unsigned int list##_idx; idx=0;\
          for(list##_idx=1;list##_idx<size;list##_idx++)\
            {if(list[list##_idx].status==0)\
               {idx=list##_idx; list[list##_idx].status=1;break;} }}\

#define list_add(list, item)\
	{\
	  (item)->next = (list)->next;\
	  (item)->prev = (list);\
	  (list)->next->prev = (item);\
	  (list)->next = (item);\
	}

#define list_add_tail(list, item)\
	{\
	  (item)->next = (list);\
	  (item)->prev = (list)->prev;\
	  (list)->prev->next = (item);\
	  (list)->prev = (item);\
	}
#define list_insert_prev list_add_tail
#define list_add_next    list_add

#define list_del(cur)\
	{\
	  (cur)->prev->next = (cur)->next;\
	  (cur)->next->prev = (cur)->prev;\
	  (cur)->prev = (cur)->next = (cur);\
	}

#define list_for_each( list, item )\
  for( (item) = (list)->next; (item) != (list); (item) = (item)->next )

#endif // LIST_H_
