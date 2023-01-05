#include <vector>

class Storage
{
    private:
        vector <int> memory;
        int count;
        int index;

    public:
        Storage(int nb_val_max)
        {
            this->count = 0;
            this->index = 0;
            this->memory = vector <int> m(nb_val_max);
        }

        bool isFull()
        {
            return count == memory.size();
        }

        bool isEmpty()
        {
            return count == 0;
        }

        virtual void add(int i)
        {
            if(!isFull())
            {
                
            }
        }

}
