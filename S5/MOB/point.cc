#include <iostream>
#include <vector>

using namespace std;

class Point
{
    private:
        double x;
        double y;

    public:
        Point(double x, double y)
        {
            this->x = x;
            this->y = y;
        }

        Point vector(Point P)
        {
            double new_x = x - P.x;
            double new_y = y - P.y;
            return Point(-new_x, -new_y);
        }

        Point translate(Point v)
        {
            return Point(x + v.x, y + v.y);
        }

        void print()
        {
            cout << "x = " << x << endl;
            cout << "y = " << y << endl;
        }
        
        Point scal(double coeff)
        {
            return Point(x * coeff, y * coeff);
        }

        double get_x()
        {
            return x;
        }

        double get_y()
        {
            return y;
        }
};

class Triangle
{
    private:
        Point a;
        Point ab;
        Point ac;

    public:
        Triangle(Point a, Point b, Point c):a(a),ab(a.vector(b)),ac(a.vector(c))
        {

        }

        double area()
        {
            double res = ab.get_x() * ac.get_y() - ab.get_y() * ac.get_x();
            if (res < 0)
            {
                res *= -1;
            }
            return res / 2;
        }

        void print()
        {
            cout << endl;
            a.print();
            cout << endl;
            ab.print();
            cout << endl;
            ac.print();
        }
};


class Polygon
{
    private:
        vector<Point> vertices;
        vector <Triangle> asTriangles;

    public:
        Polygon(vector<Point> vertices)
        {
            this->vertices = vertices;
            for (int i = 0; i < vertices.size() - 2; i++)
            {
                Triangle to_add = Triangle(vertices[0], vertices[i + 1], vertices[i + 2]);
                asTriangles.push_back(to_add);
            }
        }

        double area()
        {
            int res = 0;
            for(int i = 0; i < asTriangle.size(); i++)
            {
                res += asTriangles[i].area();
            }
            return res;
        }
};

int main()
{
    Point p = Point(0,1);
    p.print();
    Point p1 = Point(3,5);
    p1.print();
    Point p2 = p.vector(p1);
    p2.print();
    Point p3 = p1.translate(p);
    p3.print();
    Point p4 = p.scal(4);
    p4.print();
    Triangle t = Triangle(p, p1, p2);
    t.print();
    double res = t.area();
    cout << res  << endl;
}

